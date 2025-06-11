import 'package:simple_e_commerce/core/data/models/common_respons.dart';
import 'package:simple_e_commerce/core/data/network/endpoints/product_endpoint.dart';
import 'package:simple_e_commerce/core/data/network/network_config.dart';
import 'package:simple_e_commerce/core/enums/request_type.dart';
import 'package:simple_e_commerce/core/error/exceptions.dart';
import 'package:simple_e_commerce/core/params/product/create_product_params.dart';
import 'package:simple_e_commerce/core/params/product/get_product_pagination_params.dart';
import 'package:simple_e_commerce/core/network/network_utils.dart';
import 'package:simple_e_commerce/data/datasources/products/product_remote_datasource.dart';
import 'package:simple_e_commerce/data/models/product_model.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final NetworkUtil networkUtil;

  ProductRemoteDataSourceImpl({required this.networkUtil});

  @override
  Future<({List<ProductModel> products, int totalPages})> getAllProducts(
    GetProductPaginationParams productPaginationParams,
  ) async {
    final String endpoint = ProductEndpoint.allProducts;
    try {
      return await NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: endpoint,
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.GET,
        ),
        params: {
          "page": productPaginationParams.page,
          "limit": productPaginationParams.limit,
        },
      ).then((response) {
        if (response != null) {
          CommonResponse<Map<String, dynamic>> commonResponse =
              CommonResponse.fromJson(response);
          if (commonResponse.getStatus) {
            List<ProductModel> resultList = [];
            commonResponse.data!["products"].forEach((element) {
              resultList.add(ProductModel.fromJson(element));
            });
            int totalPages = commonResponse.data!["totalPages"] as int;
            return (products: resultList, totalPages: totalPages);
          } else {
            throw ServerException(
              message: commonResponse.message ?? 'Invalid Input',
            );
          }
        } else {
          throw ServerException(message: 'Please check your internet');
        }
      });
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> createProduct({
    required CreateProductParams createProductParams,
  }) async {
    final String endpoint = ProductEndpoint.create;
    try {
      return await NetworkUtil.sendMultipartRequest(
        type: RequestType.POST,
        url: endpoint,
        headers: NetworkConfig.getHeaders(
          needAuth: true,
          type: RequestType.POST,
        ),
        files: {'image': createProductParams.images},
        fields: {
          'title': createProductParams.product['title'],
          'stockQuantity':
              createProductParams.product['stockQuantity'].toString(),
          'description': createProductParams.product['description'],
          'price': createProductParams.product['price'].toString(),
          'categoryId': createProductParams.product['categoryId'],
        },
      ).then((response) {
        if (response != null) {
          CommonResponse<Map<String, dynamic>> commonResponse =
              CommonResponse.fromJson(response);
          if (commonResponse.getStatus) {
            return commonResponse.message ?? '';
          } else {
            throw ServerException(
              message: commonResponse.message ?? 'Invalid Input',
            );
          }
        } else {
          throw ServerException(message: 'Please check your internet');
        }
      });
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> deleteProduct({required String productId}) async {
    final String endpoint = ProductEndpoint.delete;
    try {
      return await NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: endpoint,
        headers: NetworkConfig.getHeaders(
          needAuth: true,
          type: RequestType.POST,
        ),
        body: {'productId': productId},
      ).then((response) {
        if (response != null) {
          CommonResponse<Map<String, dynamic>> commonResponse =
              CommonResponse.fromJson(response);
          if (commonResponse.getStatus) {
            return commonResponse.message ?? '';
          } else {
            throw ServerException(
              message: commonResponse.message ?? 'Invalid Input',
            );
          }
        } else {
          throw ServerException(message: 'Please check your internet');
        }
      });
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory({
    required String categoryId,
  }) async {
    final String endpoint = ProductEndpoint.productsByCategory;
    try {
      return await NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: endpoint + categoryId,
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.GET,
        ),
      ).then((response) {
        if (response != null) {
          CommonResponse<Map<String, dynamic>> commonResponse =
              CommonResponse.fromJson(response);
          if (commonResponse.getStatus) {
            List<ProductModel> resultList = [];
            commonResponse.data!["products"].forEach((element) {
              resultList.add(ProductModel.fromJson(element));
            });
            return resultList;
          } else {
            throw ServerException(
              message: commonResponse.message ?? 'Invalid Input',
            );
          }
        } else {
          throw ServerException(message: 'Please check your internet');
        }
      });
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getProductsMine(
    GetProductPaginationParams productPaginationParams,
  ) async {
    final String endpoint = ProductEndpoint.productMine;
    try {
      return await NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: endpoint,
        headers: NetworkConfig.getHeaders(
          needAuth: true,
          type: RequestType.POST,
        ),
        params: {
          "page": productPaginationParams.page,
          "limit": productPaginationParams.limit,
        },
      ).then((response) {
        if (response != null) {
          CommonResponse<Map<String, dynamic>> commonResponse =
              CommonResponse.fromJson(response);
          if (commonResponse.getStatus) {
            List<ProductModel> resultList = [];
            commonResponse.data!["products"].forEach((element) {
              resultList.add(ProductModel.fromJson(element));
            });
            return resultList;
          } else {
            throw ServerException(
              message: commonResponse.message ?? 'Invalid Input',
            );
          }
        } else {
          throw ServerException(message: 'Please check your internet');
        }
      });
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<ProductModel>> searchProduct(
    GetProductPaginationParams productPaginationParams,
  ) async {
    final String endpoint = ProductEndpoint.searchProduct;
    try {
      return await NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: endpoint,
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.GET,
        ),
        params: {
          "page": productPaginationParams.page,
          "limit": productPaginationParams.limit,
        },
      ).then((response) {
        if (response != null) {
          CommonResponse<Map<String, dynamic>> commonResponse =
              CommonResponse.fromJson(response);
          if (commonResponse.getStatus) {
            List<ProductModel> resultList = [];
            commonResponse.data!["products"].forEach((element) {
              resultList.add(ProductModel.fromJson(element));
            });
            return resultList;
          } else {
            throw ServerException(
              message: commonResponse.message ?? 'Invalid Input',
            );
          }
        } else {
          throw ServerException(message: 'Please check your internet');
        }
      });
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
