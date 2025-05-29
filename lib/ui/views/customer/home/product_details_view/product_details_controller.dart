import 'package:get/get.dart';
import 'package:simple_e_commerce/core/data/models/api/product_model.dart';
import 'package:simple_e_commerce/core/services/base_controller.dart';

class ProductDetailsController extends BaseController {
  RxInt countProduct = 0.obs;
  RxBool isProductFavorite = false.obs;
  toggleFavoriteStatus(ProductModel productDetails){}
}
