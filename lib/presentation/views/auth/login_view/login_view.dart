import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_e_commerce/app/di/service_locator.dart';
import 'package:simple_e_commerce/core/translation/app_translation.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:simple_e_commerce/core/utils/string_urtil.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:simple_e_commerce/presentation/controllers/auth/login/login_cubit.dart';
import 'package:simple_e_commerce/presentation/views/auth/forget_password_view/forget_password_view.dart';
import 'package:simple_e_commerce/presentation/views/auth/sign_up_view/sign_up_main.dart';
import 'package:simple_e_commerce/presentation/views/customer/home/main_view.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_button.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text_field.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_toast.dart';
import 'package:simple_e_commerce/core/utils/extension_sizebox.dart';

class LoginPageWrapper extends StatelessWidget {
  const LoginPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginCubit>(),
      child: LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final GlobalKey<FormState> _formKey1 = GlobalKey(
    debugLabel: 'loginScreenKey',
  );

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    // final cubit = LoginCubit.get(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.whiteColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Form(
            key: _formKey1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                (0.1.sh).ph,
                SvgPicture.asset(
                  'assets/images/ic_splash.svg',
                  width: 120.w,
                  color: AppColors.mainColor,
                ),
                (10.h).ph,
                CustomText(
                  isTextAlign: TextAlign.center,
                  text: 'EsyShop',
                  textType: TextStyleType.title,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.textColor2,
                ),
                (80.h).ph,
                CustomText(
                  text: tr('Welcome'),
                  textType: TextStyleType.title,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.blackColor,
                ),
                (15.h).ph,
                CustomText(
                  text: tr('Login to your account'),
                  textType: TextStyleType.bodyBig,
                  fontWeight: FontWeight.normal,
                  textColor: AppColors.blackColor,
                  startPadding: 15.w,
                ),
                (10.h).ph,
                CustomTextFormField(
                  hintText: tr('Email'),
                  controller: cubit.emailController,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !StringUtil.isEmail(value)) {
                      return tr('please check your email');
                    }
                    return null;
                  },
                ),
                (25.h).ph,
                BlocSelector<LoginCubit, LoginState, bool>(
                  selector:
                      (state) =>
                          state is ToggleShowPassState ? state.showPass : false,
                  builder: (context, showPass) {
                    return CustomTextFormField(
                      suffixWidget: InkWell(
                        onTap:
                            () => context.read<LoginCubit>().toggleShowPass(),
                        child: Icon(
                          showPass
                              ? Icons.remove_red_eye
                              : Icons.visibility_off_outlined,
                          color: AppColors.mainColor,
                        ),
                      ),
                      hintText: tr('Password'),
                      obscureText: !showPass,
                      controller: cubit.passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return tr('please check your password');
                        }
                        return null;
                      },
                    );
                  },
                ),
                (10.h).ph,
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => ForgetPasswordView()),
                    );
                  },
                  child: CustomText(
                    isTextAlign: TextAlign.right,
                    text: tr('Forget Password'),
                    textType: TextStyleType.small,
                    textColor: AppColors.mainColor,
                  ),
                ),
                (25.h).ph,
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is LoginInError) {
                      CustomToast.showMessage(message: state.message);
                    }
                    if (state is LoginInSuccess) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => MainView()),
                      );
                      CustomToast.showMessage(message: 'Succefully Login');
                      cubit.clearLoginControllers();
                    } else if (state is LoginAsGuest) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => MainView()),
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      width: 1.sw,
                      height: 50.h,
                      buttonTypeEnum: ButtonTypeEnum.normal,
                      onPressed:
                          state is LoginInLoading
                              ? null
                              : () async {
                                if (_formKey1.currentState!.validate()) {
                                  await cubit.login();
                                }
                              },
                      text: 'Login',
                      child:
                          state is LoginInLoading
                              ? SpinKitCircle(
                                color: AppColors.whiteColor,
                                size: 45.w,
                              )
                              : null,
                    );
                  },
                ),
                const Spacer(),
                CustomText(
                  isTextAlign: TextAlign.center,
                  text: tr('you don\'t have an account yet'),
                  textType: TextStyleType.small,
                ),
                (10.h).ph,
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => SignUpMainWrapper()),
                    );
                  },
                  child: CustomText(
                    isTextAlign: TextAlign.center,
                    text: tr('Create One'),
                    textType: TextStyleType.bodyBig,
                    textColor: AppColors.mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                (10.h).ph,
                Divider(),
                (10.h).ph,
                CustomButton(
                  text: 'Continue as Guest',
                  buttonTypeEnum: ButtonTypeEnum.normal,
                  backgroundColor: AppColors.whiteColor,
                  textColor: AppColors.blackColor,
                  onPressed: () {
                    cubit.loginAsGuest();
                  },
                ),
                (35.h).ph,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
