import 'package:dartz/dartz.dart';
import 'package:travel_app/core/error/failure_class.dart';
import 'package:travel_app/feature/login/domain/entity/user_entity.dart';

abstract class AuthRepository {
  // signInWithPhone
  Future<Either<Failure, UserEntity>> signInWithPhone(String phoneNumber);

  // verifyPhoneOTP
  Future<Either<Failure, UserEntity>> verifyPhoneOTP(
    String verificationId,
    String smsCode,
  );

  // signInWithGoogle
  Future<Either<Failure, UserEntity>> signInWithGoogle();

  // signInWithApple
  Future<Either<Failure, UserEntity>> signInWithApple();

  // signInWithEmail
  Future<Either<Failure, UserEntity>> signInWithEmail(
    String email,
    String password,
  );
  
  // sendEmailVerification
  Future<Either<Failure, void>> sendEmailVerification();

  // isEmailVerified
  Future<Either<Failure, bool>> isEmailVerified();

  // saveUserData
  Future<Either<Failure, void>> saveUserData(UserEntity user);

  // getCurrentUser
  Future<Either<Failure, UserEntity?>> getCurrentUser();

  // signOut
  Future<Either<Failure, void>> signOut();
}
