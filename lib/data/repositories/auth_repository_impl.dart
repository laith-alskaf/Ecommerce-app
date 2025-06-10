import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/error/exceptions.dart';
import 'package:simple_e_commerce/core/error/failure.dart';
import 'package:simple_e_commerce/core/network/network_info.dart';
import 'package:simple_e_commerce/core/params/auth/login_params.dart';
import 'package:simple_e_commerce/core/params/auth/reset_password_params.dart';
import 'package:simple_e_commerce/core/params/auth/send_code_params.dart';
import 'package:simple_e_commerce/core/params/auth/signup_params.dart';
import 'package:simple_e_commerce/core/params/auth/verify_params.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:simple_e_commerce/data/datasources/auth/remote/auth_remote_datasource.dart';
import 'package:simple_e_commerce/domain/entities/user_entity.dart';
import 'package:simple_e_commerce/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> login({
    required LoginParams loginParams,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCategories = await remoteDataSource.login(
          loginParams: loginParams,
        );
        storage.setToken(remoteCategories.token);
        return Right(remoteCategories.userModel);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message ?? 'Server Error'));
      } on NetworkException catch (e) {
        return Left(OfflineFailure(message: e.message ?? 'Network Error'));
      }
    } else {
      return Left(OfflineFailure(message: "No internet connection."));
    }
  }

  @override
  Future<Either<Failure, String>> signOut() async {
    await remoteDataSource.signOut();
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUp({
    required SignUpParams signUpParams,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteSignUp = await remoteDataSource.signUp(
          signUpParams: signUpParams,
        );
        return Right(remoteSignUp);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message ?? 'Server Error'));
      }
    } else {
      return Left(OfflineFailure(message: "No internet connection."));
    }
  }

  @override
  Future<Either<Failure, String>> verify({
    required VerifyParams verifyParams,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteVerify = await remoteDataSource.verify(
          verifyParams: verifyParams,
        );
        return Right(remoteVerify);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message ?? 'Server Error'));
      }
    } else {
      return Left(OfflineFailure(message: "No internet connection."));
    }
  }

  @override
  Future<Either<Failure, String>> sendCode({
    required SendCodeParams sendCodeParams,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteSendCode = await remoteDataSource.sendCode(
          sendCodeParams: sendCodeParams,
        );
        return Right(remoteSendCode);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message ?? 'Server Error'));
      }
    } else {
      return Left(OfflineFailure(message: "No internet connection."));
    }
  }



  @override
  Future<Either<Failure, String>> resetPassword({
    required ResetPasswordParams resetPasswordParams,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteResetPassword = await remoteDataSource.resetPassword(
          resetPasswordParams: resetPasswordParams,
        );
        return Right(remoteResetPassword);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message ?? 'Server Error'));
      }
    } else {
      return Left(OfflineFailure(message: "No internet connection."));
    }
  }
}
