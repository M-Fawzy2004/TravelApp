// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/core/services/auth_service.dart';
import 'package:travel_app/feature/auth/domain/entity/user_entity.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService authService;

  AuthCubit(this.authService) : super(AuthInitial());

  Future<void> signInWithPhone(String phone) async {
    emit(AuthLoading());
    try {
      final user = await authService.signInWithPhone(phone);
      emit(AuthCodeSent(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> verifyOTP(String verificationId, String code) async {
    emit(AuthLoading());
    try {
      final user = await authService.verifyOTP(verificationId, code);
      if (user.firstName == null || user.firstName!.isEmpty) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthAuthenticated(user));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    try {
      var user = await authService.signInWithGoogle();
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signInWithApple() async {
    emit(AuthLoading());
    try {
      var user = await authService.signInWithApple();
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await authService.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> storeUserTemporarily(UserEntity user) async {
    emit(AuthLoading());
    try {
      authService.storeTemporaryUserData(user);
      emit(AuthTemporarilySaved(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> confirmUserData() async {
    emit(AuthLoading());
    try {
      await authService.confirmUserData();
      final currentUser = await authService.getCurrentUser();
      if (currentUser != null) {
        emit(AuthAuthenticated(currentUser));
      } else {
        emit(AuthInitial());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void cancelTemporaryUserData() {
    authService.cancelTemporaryUserData();
  }

  bool isValidEgyptianLicense(String? license) {
    if (license == null || license.isEmpty) {
      return false;
    }

    final cleanLicense = license.trim();

    final hasArabicLetters = RegExp(r'[\u0600-\u06FF]').hasMatch(cleanLicense);

    final hasNumbers = RegExp(r'[0-9]').hasMatch(cleanLicense);

    return hasArabicLetters &&
        hasNumbers &&
        cleanLicense.length >= 3 &&
        cleanLicense.length <= 10;
  }

  Future<void> saveUser(UserEntity user) async {
    emit(AuthLoading());
    try {
      await authService.saveUserData(user);
      emit(AuthSaved(user));
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> saveUserLocation(String userId, double latitude,
      double longitude, String locationName) async {
    emit(AuthLoading());
    try {
      final currentUser = await authService.getCurrentUser();
      if (currentUser != null) {
        final updatedUser = currentUser.copyWith(
          latitude: latitude,
          longitude: longitude,
          locationName: locationName,
        );

        // Save updated user data
        await authService.saveUserData(updatedUser);

        emit(AuthSaved(updatedUser));
        emit(AuthAuthenticated(updatedUser));
      } else {
        emit(const AuthError('لم يتم العثور على المستخدم'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> clearUserLocation() async {
    emit(AuthLoading());
    try {
      // Get current user
      final currentUser = await authService.getCurrentUser();
      if (currentUser != null) {
        // Update user with null location data
        final updatedUser = currentUser.copyWith(
          latitude: null,
          longitude: null,
          locationName: null,
        );

        // Save updated user data
        await authService.saveUserData(updatedUser);

        emit(AuthSaved(updatedUser));
        emit(AuthAuthenticated(updatedUser));
      } else {
        emit(const AuthError('لم يتم العثور على المستخدم'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> getCurrentUser() async {
    emit(AuthLoading());
    try {
      final user = await authService.getCurrentUser();
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthInitial());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> linkPhoneToCurrentUser(String phoneNumber) async {
    try {
      emit(AuthLoading());
      await authService.linkPhoneNumber(phoneNumber);
      final user = await authService.getCurrentUser();
      emit(AuthAuthenticated(user!));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
