import 'package:dio/dio.dart';
import 'package:simple_e_commerce/core/data/models/common_respons.dart';
import 'package:simple_e_commerce/core/data/network/endpoints/category_endpoints.dart';
import 'package:simple_e_commerce/core/data/network/endpoints/product_endpoint.dart';
import 'package:simple_e_commerce/core/data/network/network_config.dart';
import 'package:simple_e_commerce/core/enums/request_type.dart';
import 'package:simple_e_commerce/core/error/exceptions.dart';
import 'package:simple_e_commerce/core/utils/network_utils.dart';
import 'package:simple_e_commerce/data/datasources/products/product_remote_datasource.dart';
import 'package:simple_e_commerce/data/models/product_model.dart';

// Assuming NetworkConfig might be needed for headers, though for GET it might not be.
// import 'package:simple_e_commerce/core/data/network/network_config.dart';
// import 'package:simple_e_commerce/core/enums/request_type.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final NetworkUtil networkUtil;

  ProductRemoteDataSourceImpl({required this.networkUtil});

  @override
  Future<({List<ProductModel> products, int totalPages})>
  getAllProducts({
    int page = 1,
    int limit = 10,
  }) async {
    final String endpoint = ProductEndpoint.allProducts;
    try {
      return await NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: endpoint,
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.GET,
        ),
        params: {"page": page, "limit": limit},
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
}
