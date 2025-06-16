import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_e_commerce/app/di/service_locator.dart';
import 'package:simple_e_commerce/core/translation/app_translation.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:simple_e_commerce/core/utils/string_urtil.dart';
import 'package:simple_e_commerce/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:simple_e_commerce/presentation/controllers/auth/signup/signup_cubit.dart';
import 'package:simple_e_commerce/presentation/views/auth/login_view/login_view.dart';
import 'package:simple_e_commerce/presentation/views/auth/sign_up_view/sign_up_widget/check_email.dart';
import 'package:simple_e_commerce/presentation/views/auth/sign_up_view/sign_up_widget/company_form.dart';
import 'package:simple_e_commerce/presentation/views/auth/sign_up_view/sign_up_widget/custom_dilog.dart';
import 'package:simple_e_commerce/presentation/views/auth/sign_up_view/sign_up_widget/user_form.dart';
import 'package:simple_e_commerce/presentation/views/auth/sign_up_view/sign_up_widget/verify.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_button.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text.dart';
import 'package:simple_e_commerce/presentation/widgets/custom_text_field.dart';

class SignUpMainWrapper extends StatelessWidget {
  const SignUpMainWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SignUpCubit>(),
      child: SignUpMain(),
    );
  }
}

class SignUpMain extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SignUpMain({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();
    return PopScope(
      onPopInvoked: (pop) {
        if (cubit.currentIndex != 0) {
          cubit.currentIndex--;
          return;
        } else {
          Navigator.of(
            context,
          ).pushReplacement(MaterialPageRoute(builder: (_) => LoginView()));
        }
      },

      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: BlocBuilder<SignUpCubit, SignUpState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: IntrinsicHeight(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 0.05.sh),
                          if (cubit.currentIndex != 0)
                            SvgPicture.asset(
                              'assets/images/ic_${cubit.imageSignUp[cubit.currentIndex]}.svg',
                              width: 200.w,
                              height: 150.h,
                            ),
                          if (cubit.currentIndex == 0)
                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: CustomText(
                                text: tr('Let’s Create New Account'),
                                textType: TextStyleType.bodyBig,
                                textColor: AppColors.blackColor,
                                startPadding: 15.w,
                              ),
                            ),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(cubit.imageSignUp.length, (
                              index,
                            ) {
                              return Container(
                                margin: EdgeInsetsDirectional.only(
                                  end:
                                      index + 1 == cubit.imageSignUp.length
                                          ? 0
                                          : 20.w,
                                ),
                                height: 10.h,
                                width: 10.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.r),
                                  color:
                                      cubit.currentIndex == index
                                          ? AppColors.mainColor
                                          : AppColors.backgroundColor,
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  icon: Icon(Icons.person_outline),
                                  label: Text('User'.tr),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        cubit.selectedRole == 'customer'
                                            ? AppColors.mainColor
                                            : Colors.grey[300],
                                    foregroundColor:
                                        cubit.selectedRole == 'customer'
                                            ? Colors.white
                                            : Colors.black,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 12.h,
                                    ),
                                  ),
                                  onPressed: () async {
                                    await cubit.selectRole(role: 'customer');
                                  },
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: ElevatedButton.icon(
                                  icon: Icon(Icons.business_outlined),
                                  label: Text('Company'.tr),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        cubit.selectedRole == 'admin'
                                            ? AppColors.mainColor
                                            : Colors.grey[300],
                                    foregroundColor:
                                        cubit.selectedRole == 'admin'
                                            ? Colors.white
                                            : Colors.black,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 12.h,
                                    ),
                                  ),
                                  onPressed: () async {
                                    await cubit.selectRole(role: 'admin');
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          if (cubit.currentIndex == 0) ...[
                            CustomTextFormField(
                              hintText: tr('Email'),
                              keyboardType: TextInputType.emailAddress,
                              controller: cubit.emailController,
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !StringUtil.isEmail(value)) {
                                  return tr('please check your email');
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 25.h),
                            BlocSelector<SignUpCubit, SignUpState, bool>(
                              selector: (state) {
                                if (state is ToggleShowPassState) {
                                  return state.showPass;
                                } else {
                                  return true;
                                }
                              },
                              builder: (context, state) {
                                return CustomTextFormField(
                                  suffixWidget: InkWell(
                                    onTap: () => cubit.toggleShowPass(index: 0),
                                    child: Icon(
                                      state
                                          ? Icons.visibility_off_outlined
                                          : Icons.remove_red_eye,
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                  obscureText: state,
                                  controller: cubit.passwordController,
                                  hintText: tr('Password'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return tr('please check your password');
                                    }
                                    if (value.length <= 7) {
                                      return tr('please input more than 7');
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),
                            SizedBox(height: 25.h),
                            BlocSelector<SignUpCubit, SignUpState, bool>(
                              selector: (state) {
                                if (state is ToggleShowPassState) {
                                  return state.showConfirmPass;
                                } else {
                                  return true;
                                }
                              },
                              builder: (context, state) {
                                return CustomTextFormField(
                                  obscureText: state,
                                  suffixWidget: InkWell(
                                    onTap: () => cubit.toggleShowPass(index: 1),
                                    child: Icon(
                                      state
                                          ? Icons.visibility_off_outlined
                                          : Icons.remove_red_eye,
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                  controller: cubit.confirmController,
                                  hintText: tr('Confirm Password'),
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        cubit.passwordController.text !=
                                            cubit.confirmController.text) {
                                      return tr(
                                        'please check your confirm password',
                                      );
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),

                            SizedBox(height: 10.h),
                            BlocSelector<SignUpCubit, SignUpState, bool>(
                              selector: (state) {
                                return state.role == 'admin' ? true : false;
                              },
                              builder: (context, state) {
                                return state
                                    ? CompanyForm(controller: cubit)
                                    : const SizedBox();
                              },
                            ),

                            BlocSelector<SignUpCubit, SignUpState, bool>(
                              selector: (state) {
                                return state.role == 'customer' ? true : false;
                              },
                              builder: (context, state) {
                                return state
                                    ? UserForm(controller: cubit)
                                    : const SizedBox();
                              },
                            ),

                            SizedBox(height: 25.h),
                            CustomButton(
                              width: 1.sw,
                              height: 50.h,
                              buttonTypeEnum: ButtonTypeEnum.normal,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  showCheckEmailDialog(
                                    email: cubit.emailController.text,
                                    context: context,
                                  );
                                }
                              },
                              text: tr('Next'),
                            ),
                            SizedBox(height: 25.h),
                            CustomText(
                              isTextAlign: TextAlign.center,
                              text: tr('Already have account'),
                              textType: TextStyleType.small,
                            ),
                            SizedBox(height: 10.h),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (_) => LoginPageWrapper(),
                                  ),
                                );
                              },
                              child: CustomText(
                                isTextAlign: TextAlign.center,
                                text: 'Login'.tr,
                                textType: TextStyleType.bodyBig,
                                textColor: AppColors.mainColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 35.h),
                          ],
                          if (cubit.currentIndex == 1) ...[
                            SignUpCheckEmail(controller: cubit),
                          ],
                          if (cubit.currentIndex == 2) ...[
                            SignUpVerify(
                              onPressedVerify: () {
                                cubit.sendCode();
                              },
                              onPressedResend: () {
                                cubit.verify();
                              },
                              controller: cubit.verifyCodeController,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
