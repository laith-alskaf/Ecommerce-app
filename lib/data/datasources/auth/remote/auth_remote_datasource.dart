import 'package:simple_e_commerce/data/models/user_model.dart';
import 'package:simple_e_commerce/core/params/auth/login_params.dart';
import 'package:simple_e_commerce/core/params/auth/reset_password_params.dart';
import 'package:simple_e_commerce/core/params/auth/send_code_params.dart';
import 'package:simple_e_commerce/core/params/auth/signup_params.dart';
import 'package:simple_e_commerce/core/params/auth/verify_params.dart';

abstract class AuthRemoteDataSource {
  Future<({String token, UserModel userModel})> login({required LoginParams loginParams});
  Future<String> signUp({required SignUpParams signUpParams});
  Future<String> signOut();
  Future<String> verify({required VerifyParams verifyParams});
  Future<String> sendCode({required SendCodeParams sendCodeParams});
  Future<String> resetPassword({
    required ResetPasswordParams resetPasswordParams,
  });
}
