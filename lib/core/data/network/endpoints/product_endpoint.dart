import 'package:simple_e_commerce/core/data/network/network_config.dart';

class ProductEndpoint {
  static String allProducts = NetworkConfig.getFullApiRout('product/');
  static String productsByCategory = NetworkConfig.getFullApiRout('product/byCategoryId/');
  static String searchProduct = NetworkConfig.getFullApiRout('product/search/');
}
