import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/data/models/common_respons.dart';
import 'package:simple_e_commerce/core/data/network/endpoints/product_endpoint.dart';
import 'package:simple_e_commerce/core/data/network/network_config.dart';
import 'package:simple_e_commerce/core/enums/request_type.dart';
import 'package:simple_e_commerce/core/translation/app_translation.dart';
import 'package:simple_e_commerce/core/network/network_utils.dart';
import 'package:simple_e_commerce/domain/entities/product_entity.dart';

import '../../../data/models/product_model.dart';

class ProductRepositories {
  static Future<Either<String, ({List<ProductModel> products, int totalPages})>> getProducts({
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
            int totalPages = commonResponse.data!["totalPages"] as int;
            return Right((products: resultList, totalPages: totalPages));
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

  static Future<Either<String, List<ProductEntity>>> searchProduct({
    required String title,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: ProductEndpoint.searchProduct,
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.GET,
        ),

        params: {"title": title,"page": page, "limit": limit},
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

  static Future<Either<String, List<ProductModel>>> getProductsMine({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: ProductEndpoint.productMine,
        headers: NetworkConfig.getHeaders(
          needAuth: true,
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

  static Future<Either<String, String>> createProduct({
    required Map<String, dynamic> product,
    required File image,
  }) async {
    try {
      return NetworkUtil.sendMultipartRequest(
        type: RequestType.POST,
        url: ProductEndpoint.create,
        headers: NetworkConfig.getHeaders(
          needAuth: true,
          type: RequestType.POST,
        ),
        files: {'image': [image.path]},
        fields: {
          'title': product['title'],
          'stockQuantity': product['stockQuantity'].toString(),
          'description': product['description'],
          'price': product['price'].toString(),
          'categoryId': product['categoryId'],
        },
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

  static Future<Either<String, String>> deleteProduct({
    required String productId,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: ProductEndpoint.delete,
        headers: NetworkConfig.getHeaders(
          needAuth: true,
          type: RequestType.POST,
        ),
        body: {'productId': productId},
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
