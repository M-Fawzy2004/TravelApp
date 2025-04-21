import 'package:dartz/dartz.dart';
import 'package:travel_app/core/error/failure_class.dart';
import 'package:travel_app/feature/auth/domain/entity/user_entity.dart';

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


  // saveUserData
  Future<Either<Failure, void>> saveUserData(UserEntity user);

  // getCurrentUser
  Future<Either<Failure, UserEntity?>> getCurrentUser();

  // signOut
  Future<Either<Failure, void>> signOut();
}
