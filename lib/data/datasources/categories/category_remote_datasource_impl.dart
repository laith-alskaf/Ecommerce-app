import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:simple_e_commerce/core/data/models/common_respons.dart';
import 'package:simple_e_commerce/core/data/network/endpoints/category_endpoints.dart';
import 'package:simple_e_commerce/core/data/network/network_config.dart';
import 'package:simple_e_commerce/core/enums/request_type.dart';
import 'package:simple_e_commerce/core/error/exceptions.dart';
import 'package:simple_e_commerce/core/network/network_utils.dart';
import 'package:simple_e_commerce/data/datasources/categories/category_remote_datasource.dart';
import 'package:simple_e_commerce/data/models/category_model.dart';

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final NetworkUtil networkUtil;

  CategoryRemoteDataSourceImpl({required this.networkUtil});

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final String endpoint = CategoryEndpoint.allCategories;
    try {
      return await NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: endpoint,
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.GET,
        ),
      ).then((response) {
        if (response != null) {
          CommonResponse<Map<String, dynamic>> commonResponse =
              CommonResponse.fromJson(response);
          if (commonResponse.getStatus) {
            List<CategoryModel> resultList = [];
            commonResponse.data!["categories"].forEach((element) {
              resultList.add(CategoryModel.fromJson(element));
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
