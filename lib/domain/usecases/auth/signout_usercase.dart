import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/error/failure.dart';
import 'package:simple_e_commerce/core/usecases/usecase.dart';
import 'package:simple_e_commerce/domain/repositories/auth_repository.dart';

class SignOutUseCase implements Usecase<String, NoParams> {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await repository.signOut();
  }
}