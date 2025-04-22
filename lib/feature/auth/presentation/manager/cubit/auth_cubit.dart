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
      await authService.saveUserData(user);
      emit(AuthCodeSent(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> verifyOTP(String verificationId, String code) async {
    emit(AuthLoading());
    try {
      final user = await authService.verifyOTP(verificationId, code);
      await authService.saveUserData(user);
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

  Future<void> saveUser(UserEntity user) async {
    emit(AuthLoading());
    try {
      await authService.saveUserData(user);
      emit(AuthSaved(user));
      // Update to authenticated state with updated user data
      emit(AuthAuthenticated(user));
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
