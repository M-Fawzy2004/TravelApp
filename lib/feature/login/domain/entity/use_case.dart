import 'package:dartz/dartz.dart';
import 'package:travel_app/core/error/failure_class.dart';
import 'package:travel_app/feature/login/domain/repos/auth_repo.dart';
import 'package:travel_app/feature/login/domain/entity/user_entity.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class SignInWithPhone implements UseCase<UserEntity, String> {
  final AuthRepository repository;

  SignInWithPhone(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(String phoneNumber) {
    return repository.signInWithPhone(phoneNumber);
  }
}

class VerifyPhoneOTP implements UseCase<UserEntity, OTPParams> {
  final AuthRepository repository;

  VerifyPhoneOTP(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(OTPParams params) {
    return repository.verifyPhoneOTP(params.verificationId, params.smsCode);
  }
}

class SignInWithGoogle implements UseCase<UserEntity, NoParams> {
  final AuthRepository repository;

  SignInWithGoogle(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) {
    return repository.signInWithGoogle();
  }
}

class SignInWithApple implements UseCase<UserEntity, NoParams> {
  final AuthRepository repository;

  SignInWithApple(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) {
    return repository.signInWithApple();
  }
}

class SaveUserData implements UseCase<void, UserEntity> {
  final AuthRepository repository;

  SaveUserData(this.repository);

  @override
  Future<Either<Failure, void>> call(UserEntity user) {
    return repository.saveUserData(user);
  }
}

class GetCurrentUser implements UseCase<UserEntity?, NoParams> {
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) {
    return repository.getCurrentUser();
  }
}

// Extra helper classes for parameters
class NoParams {}

class OTPParams {
  final String verificationId;
  final String smsCode;

  OTPParams({required this.verificationId, required this.smsCode});
}

class EmailPasswordParams {
  final String email;
  final String password;

  EmailPasswordParams({required this.email, required this.password});
}