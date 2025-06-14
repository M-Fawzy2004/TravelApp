// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:travel_app/constant.dart';
import 'package:travel_app/core/services/shared_preference_singleton.dart';
import 'package:travel_app/feature/auth/data/model/user_model.dart';
import 'package:travel_app/feature/auth/domain/entity/user_entity.dart';

class AuthService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  UserEntity? _temporaryUserData;

  AuthService({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  void storeTemporaryUserData(UserEntity user) {
    _temporaryUserData = user;
  }

  Future<void> confirmUserData() async {
    if (_temporaryUserData != null) {
      await saveUserData(_temporaryUserData!);
      _temporaryUserData = null;
    }
  }

  void cancelTemporaryUserData() {
    _temporaryUserData = null;
  }

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      final docSnapshot = await _firestore.collection(kUsers).doc(userId).get();
      if (docSnapshot.exists) {
        print("Firebase document exists for user $userId");
        return docSnapshot.data();
      }
      print("No Firebase document found for user $userId");
      return null;
    } catch (e) {
      print('Error getting user data from Firestore: $e');
      return null;
    }
  }

  Future<void> linkPhoneNumber(String phoneNumber) async {
    final completer = Completer<void>();

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      // تعطيل التحقق التلقائي من Google
      verificationCompleted: (PhoneAuthCredential credential) async {
        // لا تعمل sign in تلقائي - فقط أكمل العملية
        print("تم إرسال كود التحقق");
        completer.complete();
      },
      verificationFailed: (FirebaseAuthException e) {
        completer.completeError(e);
      },
      codeSent: (String verificationId, int? resendToken) async {},
      codeAutoRetrievalTimeout: (String verificationId) {},
      // إضافة إعدادات لتعطيل التحقق التلقائي
      timeout: const Duration(seconds: 60),
    );

    return completer.future;
  }

  // تسجيل الدخول برقم الهاتف مع تعطيل التحقق التلقائي
  Future<UserEntity> signInWithPhone(String phoneNumber) async {
    try {
      final completer = Completer<UserEntity>();

      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        // تعطيل التحقق التلقائي - لا تقوم بتسجيل دخول تلقائي
        verificationCompleted: (PhoneAuthCredential credential) async {
          // بدلاً من تسجيل الدخول، فقط أرسل رسالة أن الكود وصل
          print("تم التحقق التلقائي ولكن سيتم تجاهله - يرجى إدخال الكود");
          // لا تستدعي signInWithCredential هنا
        },
        verificationFailed: (FirebaseAuthException e) {
          completer.completeError(Exception(e.message ?? 'فشل التحقق'));
        },
        codeSent: (String verificationId, int? resendToken) {
          // إرجاع UserEntity مع verification ID للاستخدام في التحقق اليدوي
          completer.complete(
            UserEntity(
              id: verificationId,
              phoneNumber: phoneNumber,
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          if (!completer.isCompleted) {
            completer.completeError(
              Exception('انتهاء مهلة الاسترجاء التلقائي لـ OTP'),
            );
          }
        },
        timeout: const Duration(seconds: 60),
      );

      return completer.future;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // التحقق من OTP بشكل يدوي فقط
  Future<UserEntity> verifyOTP(String verificationId, String smsCode) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        final userModel = await _getOrCreateUser(user);
        return userModel;
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

      if (user == null) {
        throw Exception('فشل تسجيل الدخول باستخدام Google');
      }

      final userModel = await _getOrCreateUser(user);
      return userModel;
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

        return userModel;
      } else {
        throw Exception('فشل تسجيل الدخول باستخدام Apple');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Save user data
  Future<void> saveUserData(UserEntity user) async {
    try {
      final userModel = user is UserModel ? user : UserModel.fromEntity(user);
      await _firestore.collection(kUsers).doc(user.id).set(userModel.toJson());
      final userModelJson = jsonEncode(userModel.toJson());
      await Prefs.setString(kUserData, userModelJson);
      print(
          "AuthService: User data saved to SharedPreferences and Firestore, ID: ${user.id}, role: ${user.role}");
    } catch (e) {
      print("AuthService: Error saving user data: $e");
      throw Exception(e.toString());
    }
  }

  // Get current user
  Future<UserEntity?> getCurrentUser() async {
    try {
      // Try to get from SharedPreferences first (faster)
      final userData = Prefs.getString(kUserData);
      if (userData.isNotEmpty) {
        try {
          final user = UserModel.fromJson(jsonDecode(userData));
          if (user.id.isNotEmpty) {
            print(
                "AuthService: Retrieved user from SharedPreferences, ID: ${user.id}");
            return user;
          }
        } catch (e) {
          print("AuthService: Error parsing stored user data: $e");
          // Continue to try from Firebase
        }
      }

      // If SharedPreferences failed, try from Firebase Auth
      final user = _auth.currentUser;
      if (user != null) {
        print("AuthService: Current Firebase Auth user found: ${user.uid}");
        final userData = await _getUserFromFirestore(user.uid);
        if (userData != null) {
          // Save to preferences for future fast access
          final userModelJson = jsonEncode(userData.toJson());
          await Prefs.setString(kUserData, userModelJson);
          return userData;
        } else {
          print(
              "AuthService: No user data found in Firestore for current user");
        }
      } else {
        print("AuthService: No current Firebase Auth user found");
      }
      return null;
    } catch (e) {
      print("AuthService: Error in getCurrentUser: $e");
      throw Exception(e.toString());
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      await Prefs.remove(kUserData);
      _temporaryUserData = null;
      print("AuthService: User signed out successfully");
    } catch (e) {
      print("AuthService: Error during sign out: $e");
      throw Exception(e.toString());
    }
  }

  // Helper methods
  Future<UserModel?> _getUserFromFirestore(String userId) async {
    try {
      final doc = await _firestore.collection(kUsers).doc(userId).get();
      if (doc.exists && doc.data() != null) {
        final userData = doc.data()!;
        userData['id'] = userId;
        print("AuthService: User data found in Firestore for ID: $userId");
        return UserModel.fromJson(userData);
      }
      print("AuthService: No user document found in Firestore for ID: $userId");
      return null;
    } catch (e) {
      print("AuthService: Error retrieving user from Firestore: $e");
      return null;
    }
  }

  Future<UserModel> _getOrCreateUser(User user) async {
    try {
      final existingUser = await _getUserFromFirestore(user.uid);
      if (existingUser != null) {
        print("AuthService: Using existing user data for ID: ${user.uid}");
        final userModelJson = jsonEncode(existingUser.toJson());
        await Prefs.setString(kUserData, userModelJson);
        return existingUser;
      } else {
        print("AuthService: Creating new user record for ID: ${user.uid}");
        final newUser = UserModel(
          id: user.uid,
          phoneNumber: user.phoneNumber ?? '',
          email: user.email,
          firstName: '',
          lastName: '',
          isEmailVerified: user.emailVerified,
        );
        await _firestore.collection(kUsers).doc(user.uid).set(newUser.toJson());
        final userModelJson = jsonEncode(newUser.toJson());
        await Prefs.setString(kUserData, userModelJson);
        return newUser;
      }
    } catch (e) {
      print("AuthService: Error in _getOrCreateUser: $e");
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