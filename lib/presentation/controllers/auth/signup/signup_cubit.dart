import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_e_commerce/core/enums/message_type.dart';
import 'package:simple_e_commerce/core/params/auth/send_code_params.dart';
import 'package:simple_e_commerce/core/params/auth/signup_params.dart';
import 'package:simple_e_commerce/core/params/auth/verify_params.dart';
import 'package:simple_e_commerce/domain/usecases/auth/sendcode_usecase.dart';
import 'package:simple_e_commerce/domain/usecases/auth/signup_usecase.dart';
import 'package:simple_e_commerce/domain/usecases/auth/verify_usecase.dart';
import 'package:simple_e_commerce/presentation/controllers/auth/signup/signup_mixin.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> with SignUpProviders {
  final SendCodeUseCase sendCodeUseCase;
  final VerifyUseCase verifyUseCase;
  final SignUpUseCase signUpUseCase;

  SignUpCubit(this.signUpUseCase, this.verifyUseCase, this.sendCodeUseCase)
    : super(SignUpInitial());

  Future<void> register() async {
    emit(SignUpLoading());
    final failureOrCategories = await signUpUseCase.call(
      SignUpParams(
        userName: '${firstNameController.text} ${lastNameController.text}',
        email: email,
        role: selectedRole,
        password: passwordController.text,
      ),
    );
    failureOrCategories.fold(
      (l) {

        emit(SignUpError(message: l.message));
      },
      (r) {
        emit(SignUpSuccess(message: r));
      },
    );
  }

  Future<void> verify() async {
    emit(VerifyLoading());
    final failureOrCategories = await verifyUseCase.call(
      VerifyParams(email: emailController.text),
    );
    failureOrCategories.fold(
      (l) {

        emit(VerifyError(message: l.message));
      },
      (r) {
        emit(VerifySuccess(message: r));
      },
    );
  }

  Future<void> sendCode() async {
    emit(SendCodeLoading());
    final failureOrCategories = await sendCodeUseCase.call(
      SendCodeParams(code: verifyCodeController.text),
    );
    failureOrCategories.fold(
      (l) {
        emit(SendCodeError(message: l.message));
      },
      (r) {
        emit(SendCodeSuccess(message: r));
      },
    );
  }
}
