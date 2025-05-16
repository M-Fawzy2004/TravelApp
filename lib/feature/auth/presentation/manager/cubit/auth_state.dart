part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthCodeSent extends AuthState {
  final UserEntity user;

  const AuthCodeSent(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthAuthenticated extends AuthState {
  final UserEntity user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthTemporarilySaved extends AuthState {
  final UserEntity user;

  const AuthTemporarilySaved(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthSaved extends AuthState {
  final UserEntity user;

  const AuthSaved(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}