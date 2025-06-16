import 'package:simple_e_commerce/data/models/product_model.dart';

abstract class WishlistRemoteDataSource {
  Future<({List<ProductModel> wishlist})> getWishlist();

  Future<String> addProductToWishlist({required String id});

  Future<String> removeProductFromWishlist({required String id});

  Future<String> removeAllProductsFromWishlist();
}
