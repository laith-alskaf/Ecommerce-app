import 'package:simple_e_commerce/core/data/models/common_respons.dart';
import 'package:simple_e_commerce/core/data/network/endpoints/product_endpoint.dart';
import 'package:simple_e_commerce/core/data/network/endpoints/wishlist_endpoints.dart';
import 'package:simple_e_commerce/core/data/network/network_config.dart';
import 'package:simple_e_commerce/core/enums/request_type.dart';
import 'package:simple_e_commerce/core/error/exceptions.dart';
import 'package:simple_e_commerce/core/params/product/create_product_params.dart';
import 'package:simple_e_commerce/core/params/product/get_product_pagination_params.dart';
import 'package:simple_e_commerce/core/network/network_utils.dart';
import 'package:simple_e_commerce/data/datasources/products/product_remote_datasource.dart';
import 'package:simple_e_commerce/data/datasources/wishlist/wishlist_remote_datasource.dart';
import 'package:simple_e_commerce/data/models/product_model.dart';

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  final NetworkUtil networkUtil;

  WishlistRemoteDataSourceImpl({required this.networkUtil});

  @override
  Future<({List<ProductModel> wishlist})> getWishlist() async {
    final String endpoint = WishlistEndpoints.getWishlist;
    try {
      return await NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: endpoint,
        headers: NetworkConfig.getHeaders(
          needAuth: true,
          type: RequestType.POST,
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
            return (wishlist: resultList);
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
  Future<String> addProductToWishlist({required String id}) async {
    final String endpoint = WishlistEndpoints.addProduct;
    try {
      return await NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: endpoint + id,
        headers: NetworkConfig.getHeaders(
          needAuth: true,
          type: RequestType.POST,
        ),
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
  Future<String> removeProductFromWishlist({required String id}) async {
    final String endpoint = WishlistEndpoints.deleteProduct;
    try {
      return await NetworkUtil.sendRequest(
        type: RequestType.DELETE,
        url: endpoint + id,
        headers: NetworkConfig.getHeaders(
          needAuth: true,
          type: RequestType.DELETE,
        ),
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
  Future<String> removeAllProductsFromWishlist() async {
    final String endpoint = WishlistEndpoints.deleteAllProduct;
    try {
      return await NetworkUtil.sendRequest(
        type: RequestType.DELETE,
        url: endpoint,
        headers: NetworkConfig.getHeaders(
          needAuth: true,
          type: RequestType.DELETE,
        ),
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
}
