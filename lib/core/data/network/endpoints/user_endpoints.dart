import 'package:simple_e_commerce/core/data/network/network_config.dart';

class UserEndPoints {
  static String login = NetworkConfig.getFullApiRout('auth/login');
  static String register = NetworkConfig.getFullApiRout('auth/signup');
  static String sendCode = NetworkConfig.getFullApiRout('auth/verify-email');
  static String verifyEmail = NetworkConfig.getFullApiRout('auth/forgot-password');
  static String resetPassword = NetworkConfig.getFullApiRout('auth/change-password');
  static String logout = NetworkConfig.getFullApiRout('auth/logout');

  // static String verifyResetPassword = NetworkConfig.getFullApiRout('auth/verifyResetPassCode');
  // static String editProfile = NetworkConfig.getFullApiRout('auth/settings');
}
