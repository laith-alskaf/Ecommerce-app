import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_e_commerce/app/di/service_locator.dart';
import 'package:simple_e_commerce/app/my_app_cubit.dart';
import 'package:simple_e_commerce/core/data/repositories/storage_repositories.dart';
import 'package:simple_e_commerce/core/params/auth/login_params.dart';
import 'package:simple_e_commerce/domain/entities/user_entity.dart';
import 'package:simple_e_commerce/domain/usecases/auth/login_usecase.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  LoginCubit(this.loginUseCase) : super(LoginInitial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPass = false;

  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> login() async {
    emit(LoginInLoading());
    final failureOrCategories = await loginUseCase.call(
      LoginParams(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    failureOrCategories.fold(
      (l) {
        emit(LoginInError(message: l.message));
        log('2222222222222');
      },
      (r) {
        emit(LoginInSuccess(user: r));
        log('2222222222222');
      },
    );
  }

  void clearLoginControllers() {
    emailController.clear();
    passwordController.clear();
  }

  loginAsGuest() {
    sl<MyAppCubit>().initAppRout();
    sl<SharedPreferenceRepositories>().setRole('guest');
    // Get.off(() => MainView());
    emit(LoginAsGuest());
  }

  void toggleShowPass() {
    showPass = !showPass;
    emit(ToggleShowPassState(showPass: !showPass));
  }
}
