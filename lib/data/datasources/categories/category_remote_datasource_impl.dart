import 'package:dio/dio.dart';
import 'package:simple_e_commerce/core/data/network/endpoints/category_endpoints.dart';
import 'package:simple_e_commerce/core/error/exceptions.dart';
import 'package:simple_e_commerce/core/utils/network_utils.dart';
import 'package:simple_e_commerce/data/datasources/categories/category_remote_datasource.dart';
import 'package:simple_e_commerce/data/models/category_model.dart';
// Assuming NetworkConfig might be needed for headers, though for GET it might not be.
// import 'package:simple_e_commerce/core/data/network/network_config.dart';
// import 'package:simple_e_commerce/core/enums/request_type.dart';

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final NetworkUtil networkUtil;

  CategoryRemoteDataSourceImpl({required this.networkUtil});

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final String endpoint = CategoryEndpoint.allCategories;

    try {
      final response = await Dio().get(
        'ecommerce-backend-clean-architecture.vercel.app/$endpoint',
        // options: Options(
        //   headers: NetworkConfig.getHeaders(
        //     type: RequestType.GET,
        //     needAuth: false, // Assuming fetching categories doesn't need auth
        //   ),
        // ),
      );

      if (response.statusCode == 200 && response.data != null) {
        // Based on existing CategoryRepository, response might be wrapped.
        // Let's check for a common pattern: response.data['data'] or response.data['response']
        dynamic responseData = response.data;
        List<dynamic>? categoryListJson;

        if (responseData is Map<String, dynamic>) {
          if (responseData.containsKey('data') &&
              responseData['data'] is List) {
            categoryListJson = responseData['data'] as List<dynamic>;
          } else if (responseData.containsKey('response') &&
              responseData['response'] is List) {
            categoryListJson = responseData['response'] as List<dynamic>;
          } else if (responseData.containsKey('categories') &&
              responseData['categories'] is List) {
            // another common key
            categoryListJson = responseData['categories'] as List<dynamic>;
          } else {
            // If the response itself is the list (less common for wrapped responses but possible)
            // This case needs careful checking of actual API response structure.
            // For now, let's assume it's not the direct list if response.data is a Map.
            throw ServerException(
              message:
                  "Categories data not found in expected format in response map.",
            );
          }
        } else if (responseData is List) {
          // If the response.data is directly a list
          categoryListJson = responseData;
        }

        if (categoryListJson != null) {
          return categoryListJson
              .map(
                (json) => CategoryModel.fromJson(json as Map<String, dynamic>),
              )
              .toList();
        } else {
          // This case implies the structure was not as expected or the list was missing.
          throw ServerException(
            message: "Failed to parse categories list from response.",
          );
        }
      } else {
        throw ServerException(
          message:
              "Failed to load categories: ${response.statusCode} - ${response.statusMessage}",
        );
      }
    } on DioException catch (e) {
      // You can further refine DioException handling here, e.g., for timeouts, connection errors
      throw ServerException(
        message: e.message ?? 'Dio error occurred while fetching categories.',
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

}
