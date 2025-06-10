import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/error/failure.dart';
import 'package:simple_e_commerce/core/params/auth/signup_params.dart';
import 'package:simple_e_commerce/core/usecases/usecase.dart';
import 'package:simple_e_commerce/domain/repositories/auth_repository.dart';

class SignUpUseCase implements Usecase<String, SignUpParams> {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(SignUpParams signUpParams) async {
    return await repository.signUp(signUpParams: signUpParams);
  }
}
