import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/data/models/api/product_model.dart';
import 'package:simple_e_commerce/core/data/models/common_respons.dart';
import 'package:simple_e_commerce/core/data/network/endpoints/wishlist_endpoints.dart';
import 'package:simple_e_commerce/core/data/network/network_config.dart';
import 'package:simple_e_commerce/core/enums/request_type.dart';
import 'package:simple_e_commerce/core/translation/app_translation.dart';
import 'package:simple_e_commerce/core/utils/network_utils.dart';

class WishlistRepositories {
  static Future<Either<String, List<ProductModel>>> getWishlist() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: WishlistEndpoints.getWishlist,
        headers: NetworkConfig.getHeaders(
          needAuth: true,
          type: RequestType.GET,
        ),
      ).then((response) {
        if (response != null) {
          CommonResponse<dynamic> commonResponse = CommonResponse.fromJson(
            response,
          );
          if (commonResponse.getStatus) {
            List<ProductModel> resultList = [];
            commonResponse.data!["products"].forEach((element) {
              resultList.add(ProductModel.fromJson(element));
            });
            return Right(resultList);
          } else {
            return Left(commonResponse.message ?? '');
          }
        } else {
          return Left(tr('Please check your internet'));
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  static Future<Either<String, String>> addProduct({required String id}) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: WishlistEndpoints.addProduct + id,
        headers: NetworkConfig.getHeaders(
          needAuth: true,
          type: RequestType.POST,
        ),
          body: {}
      ).then((response) {
        if (response != null) {
          CommonResponse<dynamic> commonResponse = CommonResponse.fromJson(
            response,
          );
          if (commonResponse.getStatus) {
            return Right(commonResponse.message ?? '');
          } else {
            return Left(commonResponse.message ?? '');
          }
        } else {
          return Left(tr('Please check your internet'));
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  static Future<Either<String, String>> removeProduct({
    required String id,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.DELETE,
        url: WishlistEndpoints.deleteProduct + id,
        headers: NetworkConfig.getHeaders(
          needAuth: true,
          type: RequestType.DELETE,
        ),
        body: {}
      ).then((response) {
        if (response != null) {
          CommonResponse<dynamic> commonResponse = CommonResponse.fromJson(
            response,
          );
          if (commonResponse.getStatus) {
            return Right(commonResponse.message ?? '');
          } else {
            return Left(commonResponse.message ?? '');
          }
        } else {
          return Left(tr('Please check your internet'));
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  static Future<Either<String, String>> removeAllProduct() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.DELETE,
        url: WishlistEndpoints.deleteAllProduct,
        headers: NetworkConfig.getHeaders(
          needAuth: true,
          type: RequestType.DELETE,
        ),
        body: {}
      ).then((response) {
        if (response != null) {
          CommonResponse<dynamic> commonResponse = CommonResponse.fromJson(
            response,
          );
          if (commonResponse.getStatus) {
            return Right(commonResponse.message ?? '');
          } else {
            return Left(commonResponse.message ?? '');
          }
        } else {
          return Left(tr('Please check your internet'));
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
