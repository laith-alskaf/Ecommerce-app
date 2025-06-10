import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/error/failure.dart';
import 'package:simple_e_commerce/core/params/auth/send_code_params.dart';
import 'package:simple_e_commerce/core/usecases/usecase.dart';
import 'package:simple_e_commerce/domain/repositories/auth_repository.dart';

class SendCodeUseCase implements Usecase<String, SendCodeParams> {
  final AuthRepository repository;

  SendCodeUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call( SendCodeParams sendCodeParams) async {
    return await repository.sendCode(sendCodeParams: sendCodeParams);
  }
}
