import 'package:simple_e_commerce/core/data/network/network_config.dart';

class WishlistEndpoints {
  static String addProduct = NetworkConfig.getFullApiRout('user/wishlist/');
  static String getWishlist = NetworkConfig.getFullApiRout('user/wishlist/');
  static String deleteProduct = NetworkConfig.getFullApiRout("user/wishlist/product/");
  static String deleteAllProduct = NetworkConfig.getFullApiRout("user/wishlist/all-product");
}
