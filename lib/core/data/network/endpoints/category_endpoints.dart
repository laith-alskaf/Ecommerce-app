import 'package:simple_e_commerce/core/data/network/network_config.dart';

class CategoryEndpoint {
  static String allCategories = NetworkConfig.getFullApiRout('category/');
  static String productsByCategory = NetworkConfig.getFullApiRout('category/');
}
