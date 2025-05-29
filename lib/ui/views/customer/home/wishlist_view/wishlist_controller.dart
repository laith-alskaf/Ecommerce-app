import 'package:simple_e_commerce/core/data/models/api/product_model.dart';
import 'package:simple_e_commerce/core/data/repositories/wishlist_repositories.dart';
import 'package:simple_e_commerce/core/enums/message_type.dart';
import 'package:simple_e_commerce/core/services/base_controller.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_show_snackbar.dart';
import 'package:simple_e_commerce/ui/shared/custom_widget/custom_toast.dart';

class WishlistController extends BaseController {
  List<ProductModel> wishlistItems = [];

  Future getWishlist() async {
    wishlistItems.clear();
    await runLoadingFutureFunction(
      function: WishlistRepositories.getWishlist().then((value) {
        value.fold(
          (l) {
            CustomToast.showMessage(
              message: l,
              messageType: MessageType.REJECTED,
            );
            update();
          },
          (r) {
            wishlistItems.addAll(r);
            update();
          },
        );
      }),
    );
  }

  Future removeFromWishlist({required String id}) async {
    wishlistItems.clear();
    await runLoadingFutureFunction(
      function: WishlistRepositories.removeProduct(id: id).then((value) {
        value.fold(
          (l) {
            CustomToast.showMessage(
              message: l,
              messageType: MessageType.REJECTED,
            );
            update();
          },
          (r) async {
            await getWishlist();
            showSnackBar(title: r);
          },
        );
      }),
    );
  }

  Future removeAllFromWishlist() async {
    wishlistItems.clear();
    await runLoadingFutureFunction(
      function: WishlistRepositories.removeAllProduct().then((value) {
        value.fold(
          (l) {
            CustomToast.showMessage(
              message: l,
              messageType: MessageType.REJECTED,
            );
            update();
          },
          (r) async {
            await getWishlist();
            showSnackBar(title: r);
          },
        );
      }),
    );
  }

  @override
  void onInit() async {
    await getWishlist();
    super.onInit();
  }
}
