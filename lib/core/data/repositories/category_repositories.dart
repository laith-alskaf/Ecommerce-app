import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/data/models/api/category_model.dart';
import 'package:simple_e_commerce/core/data/models/common_respons.dart';
import 'package:simple_e_commerce/core/data/network/endpoints/category_endpoints.dart';
import 'package:simple_e_commerce/core/data/network/network_config.dart';
import 'package:simple_e_commerce/core/enums/request_type.dart';
import 'package:simple_e_commerce/core/translation/app_translation.dart';
import 'package:simple_e_commerce/core/utils/network_utils.dart';

class CategoryRepositories {
  static Future<Either<String, List<CategoryModel>>> allCategory() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: CategoryEndpoint.allCategories,
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
            List<CategoryModel> categories = <CategoryModel>[];
            for (Map<String, dynamic> r in commonResponse.data['categories']) {
              categories.add(CategoryModel.fromJson(r));
            }
            return Right(categories);
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
