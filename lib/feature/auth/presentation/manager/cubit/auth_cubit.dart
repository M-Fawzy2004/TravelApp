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

      // Check if user profile is complete
      if (user.firstName == null || user.firstName!.isEmpty) {
        // User needs to complete profile
        emit(AuthAuthenticated(user));
      } else {
        // User profile is complete, authentication is successful
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

      // Check if user profile is incomplete
      if (user.firstName == null || user.firstName!.isEmpty) {
        final updatedUser = user.copyWith(
          firstName: '',
          lastName: '',
          city: '',
          role: null,
          vehicleType: null,
          seatCount: null,
        );
        await authService.saveUserData(updatedUser);
        emit(AuthAuthenticated(updatedUser));
      } else {
        emit(AuthAuthenticated(user));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signInWithApple() async {
    emit(AuthLoading());
    try {
      var user = await authService.signInWithApple();

      if (user.firstName == null || user.firstName!.isEmpty) {
        final updatedUser = user.copyWith(
          firstName: '',
          lastName: '',
          city: '',
          role: null,
          vehicleType: null,
          seatCount: null,
        );
        await authService.saveUserData(updatedUser);
        emit(AuthAuthenticated(updatedUser));
      } else {
        emit(AuthAuthenticated(user));
      }
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
}
