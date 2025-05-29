import 'package:simple_e_commerce/core/data/network/network_config.dart';

class UserrEndPoints {
  static String delete = NetworkConfig.getFullApiRout('user/me');
  static String getUserInfo = NetworkConfig.getFullApiRout('user/me');
  static String update = NetworkConfig.getFullApiRout('user/me');

// static String verifyResetPassword = NetworkConfig.getFullApiRout('auth/verifyResetPassCode');
// static String editProfile = NetworkConfig.getFullApiRout('auth/settings');
}
