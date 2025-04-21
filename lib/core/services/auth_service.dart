import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:travel_app/feature/auth/data/model/user_model.dart';
import 'package:travel_app/feature/auth/domain/entity/user_entity.dart';

class AuthService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  AuthService({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  // Sign in with phone number
  Future<UserEntity> signInWithPhone(String phoneNumber) async {
    try {
      final completer = Completer<UserEntity>();

      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          final userCredential = await _auth.signInWithCredential(credential);
          final user = userCredential.user;

          if (user != null) {
            final userModel = await _getOrCreateUser(user);
            completer.complete(userModel);
          } else {
            throw Exception('فشل في تسجيل الدخول برقم الهاتف');
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          completer.completeError(Exception(e.message ?? 'فشل التحقق'));
        },
        codeSent: (String verificationId, int? resendToken) {
          // Return the verification ID as the user ID temporarily
          completer.complete(UserEntity(
            id: verificationId,
            phoneNumber: phoneNumber,
          ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          if (!completer.isCompleted) {
            completer.completeError(
                Exception('انتهاء مهلة الاسترجاع التلقائي لـ OTP'));
          }
        },
        timeout: const Duration(seconds: 60),
      );

      return completer.future;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Verify OTP code
  Future<UserEntity> verifyOTP(String verificationId, String smsCode) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        return await _getOrCreateUser(user);
      } else {
        throw Exception('المستخدم فارغ بعد التحقق');
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'فشل التحقق من OTP');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Sign in with Google
  Future<UserEntity> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw Exception('تم إلغاء تسجيل الدخول إلى Google');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        return await _getOrCreateUser(user);
      } else {
        throw Exception('فشل تسجيل الدخول باستخدام Google');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Sign in with Apple
  Future<UserEntity> signInWithApple() async {
    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      final userCredential = await _auth.signInWithCredential(oauthCredential);
      final user = userCredential.user;

      if (user != null) {
        String? firstName =
            appleCredential.givenName ?? user.displayName?.split(' ').first;
        String? lastName =
            appleCredential.familyName ?? user.displayName?.split(' ').last;

        final userModel = await _getUserFromFirestore(user.uid) ??
            UserModel(
              id: user.uid,
              phoneNumber: user.phoneNumber ?? '',
              email: user.email ?? '',
              firstName: firstName ?? '',
              lastName: lastName ?? '',
              isEmailVerified: user.emailVerified,
            );

        await saveUserData(userModel);
        return userModel;
      } else {
        throw Exception('فشل تسجيل الدخول باستخدام Apple');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Sign in with email and password
  Future<UserEntity> signInWithEmail(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;

      if (user != null) {
        if (!user.emailVerified) {
          throw Exception('لم يتم التحقق من البريد الإلكتروني');
        }
        return await _getOrCreateUser(user);
      } else {
        throw Exception('فشل تسجيل الدخول باستخدام البريد الإلكتروني');
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'فشل تسجيل الدخول بالبريد الإلكتروني');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Send email verification
  Future<void> sendEmailVerification() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await user.sendEmailVerification();
      } else {
        throw Exception('لم يتم تسجيل دخول أي مستخدم');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Check if email is verified
  Future<bool> isEmailVerified() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await user.reload();
        return user.emailVerified;
      } else {
        throw Exception('لم يتم تسجيل دخول أي مستخدم');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Save user data
  Future<void> saveUserData(UserEntity user) async {
    try {
      final userModel = user is UserModel ? user : UserModel.fromEntity(user);
      await _firestore.collection('users').doc(user.id).set(userModel.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Get current user
  Future<UserEntity?> getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        return await _getUserFromFirestore(user.uid);
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Helper methods
  Future<UserModel?> _getUserFromFirestore(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists && doc.data() != null) {
        final userData = doc.data()!;
        userData['id'] = userId;
        return UserModel.fromJson(userData);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<UserModel> _getOrCreateUser(User user) async {
    try {
      final existingUser = await _getUserFromFirestore(user.uid);
      if (existingUser != null) {
        return existingUser;
      } else {
        final newUser = UserModel(
          id: user.uid,
          phoneNumber: user.phoneNumber ?? '',
          email: user.email,
          firstName: '',
          lastName: '',
          isEmailVerified: user.emailVerified,
        );
        await saveUserData(newUser);
        return newUser;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Helper functions for Apple Sign In
  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
