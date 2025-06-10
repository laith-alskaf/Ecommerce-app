import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_e_commerce/core/params/auth/reset_password_params.dart';
import 'package:simple_e_commerce/core/params/auth/send_code_params.dart';
import 'package:simple_e_commerce/core/params/auth/verify_params.dart';
import 'package:simple_e_commerce/domain/usecases/auth/reset_password_usecase.dart';
import 'package:simple_e_commerce/domain/usecases/auth/sendcode_usecase.dart';
import 'package:simple_e_commerce/domain/usecases/auth/verify_usecase.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final SendCodeUseCase sendCodeUseCase;
  final VerifyUsecase forgotPasswordUseCase;
  final ResetPasswordUsecase resetPasswordUseCase;

  ForgotPasswordCubit(
    this.sendCodeUseCase,
    this.forgotPasswordUseCase,
    this.resetPasswordUseCase,
  ) : super(ForgotPasswordInitial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController verifyCodeController = TextEditingController();

  Future<void> forgot() async {
    emit(ForgotPasswordLoading());
    final failureOrCategories = await forgotPasswordUseCase.call(
      VerifyParams(email: emailController.text),
    );
    failureOrCategories.fold(
      (l) {
        emit(ForgotPasswordError(message: l.message));
      },
      (r) {
        emit(ForgotPasswordSuccess(message: r));
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

  Future<void> resetPassword() async {
    emit(ResetPasswrodLoading());
    final failureOrCategories = await resetPasswordUseCase.call(
      ResetPasswordParams(
        email: emailController.text,
        newPassword: newPasswordController.text,
      ),
    );
    failureOrCategories.fold(
      (l) {
        emit(ResetPasswrodError(message: l.message));
      },
      (r) {
        emit(ResetPasswrodSuccess(message: r));
        clearForgotPasswrodControllers();
      },
    );
  }

  void clearForgotPasswrodControllers() {
    emailController.clear();
    passwordController.clear();
    newPasswordController.clear();
    verifyCodeController.clear();
  }
}
