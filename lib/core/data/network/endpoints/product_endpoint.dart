import 'package:simple_e_commerce/core/data/network/network_config.dart';

class ProductEndpoint {
  static String allProducts = NetworkConfig.getFullApiRout('product/');
  static String getSingleProduct = NetworkConfig.getFullApiRout('product/');
  static String productsByCategory = NetworkConfig.getFullApiRout('product/byCategory/');
  static String searchProduct = NetworkConfig.getFullApiRout('product/search');
  static String productMine = NetworkConfig.getFullApiRout('/user/product/');
  static String create = NetworkConfig.getFullApiRout('/user/product/');
  static String update = NetworkConfig.getFullApiRout('/user/product/');
  static String delete = NetworkConfig.getFullApiRout('/user/product/');

}
