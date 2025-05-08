import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/data/models/api/product_model.dart';
import 'package:simple_e_commerce/core/data/models/common_respons.dart';
import 'package:simple_e_commerce/core/data/network/endpoints/product_endpoint.dart';
import 'package:simple_e_commerce/core/data/network/network_config.dart';
import 'package:simple_e_commerce/core/enums/request_type.dart';
import 'package:simple_e_commerce/core/translation/app_translation.dart';
import 'package:simple_e_commerce/core/utils/network_utils.dart';

class ProductRepositories {
  static Future<Either<String, List<ProductModel>>> getProducts({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: ProductEndpoint.allProducts,
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.GET,
        ),
        params: {"page": page, "limit": limit},
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

  static Future<Either<String, List<ProductModel>>> getProductsByCategory({
    required String categoryId,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: ProductEndpoint.productsByCategory + categoryId,
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.GET,
        ),
      ).then((response) {
        if (response != null) {
          CommonResponse<dynamic> commonResponse = CommonResponse.fromJson(
            response,
          );
          if (commonResponse.getStatus) {
            List<ProductModel> resultList = [];
            commonResponse.data!["product"].forEach((element) {
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

  static Future<Either<String, List<ProductModel>>> searchProduct({
    required String title,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: ProductEndpoint.searchProduct,
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.GET,
        ),
        params: {"title": title},
      ).then((response) {
        if (response != null) {
          CommonResponse<dynamic> commonResponse = CommonResponse.fromJson(
            response,
          );
          if (commonResponse.getStatus) {
            List<ProductModel> resultList = [];
            commonResponse.data!["product"]["products"].forEach((element) {
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
}
