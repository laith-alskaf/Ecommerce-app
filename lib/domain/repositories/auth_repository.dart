import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/error/failure.dart';
import 'package:simple_e_commerce/core/params/auth/login_params.dart';
import 'package:simple_e_commerce/core/params/auth/reset_password_params.dart';
import 'package:simple_e_commerce/core/params/auth/send_code_params.dart';
import 'package:simple_e_commerce/core/params/auth/signup_params.dart';
import 'package:simple_e_commerce/core/params/auth/verify_params.dart';
import 'package:simple_e_commerce/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({required LoginParams loginParams});
  Future<Either<Failure, String>> signUp({required SignUpParams signUpParams});
  Future<Either<Failure, String>> signOut();
  Future<Either<Failure, String>> verify({required VerifyParams verifyParams});
  Future<Either<Failure, String>> sendCode({required SendCodeParams sendCodeParams});
  Future<Either<Failure, String>> resetPassword({required ResetPasswordParams resetPasswordParams});
}
