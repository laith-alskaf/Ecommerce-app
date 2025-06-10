import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/error/failure.dart';
import 'package:simple_e_commerce/core/params/auth/login_params.dart';
import 'package:simple_e_commerce/core/usecases/usecase.dart';
import 'package:simple_e_commerce/domain/entities/user_entity.dart';
import 'package:simple_e_commerce/domain/repositories/auth_repository.dart';

class LoginUseCase implements Usecase<UserEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams loginParams) async {
    return await repository.login(loginParams:loginParams );
  }
}
