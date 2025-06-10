import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/error/failure.dart';
import 'package:simple_e_commerce/core/params/auth/verify_params.dart';
import 'package:simple_e_commerce/core/usecases/usecase.dart';
import 'package:simple_e_commerce/domain/repositories/auth_repository.dart';

class VerifyUsecase implements Usecase<String, VerifyParams> {
  final AuthRepository repository;

  VerifyUsecase(this.repository);

  @override
  Future<Either<Failure, String>> call(VerifyParams verifyParams) async {
    return await repository.verify(verifyParams:verifyParams );
  }
}
