import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:travel_app/constant.dart';
import 'package:travel_app/core/error/failure_class.dart';
import 'package:travel_app/core/services/shared_preference_singleton.dart';
import 'package:travel_app/feature/auth/data/model/user_model.dart';
import 'package:travel_app/feature/auth/domain/repos/auth_repo.dart';
import 'package:travel_app/feature/auth/domain/entity/user_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  AuthRepositoryImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
    required GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  // signInWithPhone
  @override
  Future<Either<Failure, UserEntity>> signInWithPhone(
    String phoneNumber,
  ) async {
    try {
      // First ensure we're signed out to prevent using previous credentials
      await _cleanupPreviousSession();

      final completer = Completer<Either<Failure, UserEntity>>();

      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          final userCredential =
              await _firebaseAuth.signInWithCredential(credential);
          final user = userCredential.user;

          if (user != null) {
            final existingUser = await _getUserFromFirestore(user.uid);
            if (existingUser != null) {
              await _saveUserToLocalStorage(existingUser);
              completer.complete(Right(existingUser));
            } else {
              final newUser = UserModel(
                id: user.uid,
                phoneNumber: phoneNumber,
              );
              await _saveUserToFirestore(user: newUser);
              await _saveUserToLocalStorage(newUser);
              completer.complete(Right(newUser));
            }
          } else {
            completer.complete(
              const Left(
                AuthFailure(message: 'فشل في تسجيل الدخول برقم الهاتف'),
              ),
            );
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          completer.complete(
            Left(
              AuthFailure(message: e.message ?? 'فشل التحقق'),
            ),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          completer.complete(
            Right(
              UserEntity(
                id: verificationId,
                phoneNumber: phoneNumber,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          if (!completer.isCompleted) {
            completer.complete(
              const Left(
                AuthFailure(message: 'انتهاء مهلة الاسترجاع التلقائي لـ OTP'),
              ),
            );
          }
        },
        timeout: const Duration(seconds: 60),
      );

      return completer.future;
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> verifyPhoneOTP(
    String verificationId,
    String smsCode,
  ) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        final existingUser = await _getUserFromFirestore(user.uid);
        if (existingUser != null) {
          await _saveUserToLocalStorage(existingUser);
          return Right(existingUser);
        } else {
          final phoneNumber = user.phoneNumber ?? '';
          final newUser = UserModel(
            id: user.uid,
            phoneNumber: phoneNumber,
          );
          await _saveUserToFirestore(user: newUser);
          await _saveUserToLocalStorage(newUser);
          return Right(newUser);
        }
      } else {
        return const Left(AuthFailure(message: 'المستخدم فارغ بعد التحقق'));
      }
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(message: e.message ?? 'فشل التحقق من OTP'));
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      // First ensure we're signed out to prevent using previous credentials
      await _cleanupPreviousSession();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return const Left(
            AuthFailure(message: 'تم إلغاء تسجيل الدخول إلى Google'));
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        final existingUser = await _getUserFromFirestore(user.uid);
        if (existingUser != null) {
          await _saveUserToLocalStorage(existingUser);
          return Right(existingUser);
        } else {
          final newUser = UserModel(
            id: user.uid,
            phoneNumber: '',
            email: user.email ?? '',
            firstName: user.displayName?.split(' ').first,
            lastName: user.displayName?.split(' ').last,
            isEmailVerified: user.emailVerified,
          );
          await _saveUserToFirestore(user: newUser);
          await _saveUserToLocalStorage(newUser);
          return Right(newUser);
        }
      } else {
        return const Left(
            AuthFailure(message: 'فشل تسجيل الدخول باستخدام Google'));
      }
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithApple() async {
    try {
      // First ensure we're signed out to prevent using previous credentials
      await _cleanupPreviousSession();

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

      final userCredential =
          await _firebaseAuth.signInWithCredential(oauthCredential);
      final user = userCredential.user;

      if (user != null) {
        final existingUser = await _getUserFromFirestore(user.uid);

        if (existingUser != null) {
          await _saveUserToLocalStorage(existingUser);
          return Right(existingUser);
        } else {
          String? firstName =
              appleCredential.givenName ?? user.displayName?.split(' ').first;
          String? lastName =
              appleCredential.familyName ?? user.displayName?.split(' ').last;

          final newUser = UserModel(
            id: user.uid,
            phoneNumber: '',
            email: user.email ?? '',
            firstName: firstName,
            lastName: lastName,
            isEmailVerified: user.emailVerified,
          );
          await _saveUserToFirestore(user: newUser);
          await _saveUserToLocalStorage(newUser);
          return Right(newUser);
        }
      } else {
        return const Left(
            AuthFailure(message: 'فشل تسجيل الدخول باستخدام Apple'));
      }
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<void> saveUserData({required UserEntity user}) async {
    await _saveUserToLocalStorage(user);
  }

  Future<void> _saveUserToLocalStorage(UserEntity user) async {
    final userModel = jsonEncode(UserModel.fromEntity(user).toJson());
    await Prefs.setString(kUserData, userModel);
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        final userData = await _getUserFromFirestore(user.uid);
        if (userData != null) {
          await _saveUserToLocalStorage(userData);
          return Right(userData);
        }
      }

      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _cleanupPreviousSession();
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

  // Helper method to clean up previous session completely
  Future<void> _cleanupPreviousSession() async {
    try {
      // Then try to sign out from Google (ignore errors)
      try {
        await _googleSignIn.signOut();
      } catch (_) {}

      // Finally sign out from Firebase
      await _firebaseAuth.signOut();
    } catch (e) {
      // Log error but don't throw to prevent app crashes
      // ignore: avoid_print
      print('Error during session cleanup: $e');
    }
  }

  // Helper methods
  Future<UserModel?> _getUserFromFirestore(String userId) async {
    try {
      final doc = await _firestore.collection(kUsers).doc(userId).get();
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

  Future<void> _saveUserToFirestore({required UserModel user}) async {
    await _firestore.collection(kUsers).doc(user.id).set(user.toJson());
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
