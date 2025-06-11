import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/error/failure.dart';
import 'package:simple_e_commerce/core/params/auth/reset_password_params.dart';
import 'package:simple_e_commerce/core/usecases/usecase.dart';
import 'package:simple_e_commerce/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase implements Usecase<String, ResetPasswordParams> {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(
    ResetPasswordParams resetPasswordParams,
  ) async {
    return await repository.resetPassword(
      resetPasswordParams: resetPasswordParams,
    );
  }
}
