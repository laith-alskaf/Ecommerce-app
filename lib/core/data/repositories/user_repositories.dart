import 'dart:developer';
import 'package:simple_e_commerce/core/data/models/api/user_model.dart';
import 'package:simple_e_commerce/core/translation/app_translation.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/data/models/common_respons.dart';
import 'package:simple_e_commerce/core/data/network/endpoints/user_endpoints.dart';
import 'package:simple_e_commerce/core/data/network/network_config.dart';
import 'package:simple_e_commerce/core/enums/request_type.dart';
import 'package:simple_e_commerce/core/utils/network_utils.dart';

class UserRepository {
  Future<Either<String, String>> login({
    required String email,
    required String password,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: UserEndPoints.login,
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.POST,
        ),
        body: {'email': email, 'password': password},
      ).then((response) {
        if (response != null) {
          log('==========> $response');
          CommonResponse<Map<String, dynamic>> commonResponse =
              CommonResponse.fromJson(response);
          if (commonResponse.getStatus) {
            storage.setToken(commonResponse.data!['token']);
            storage.setRole(commonResponse.data!['userInfo']['role']);
            storage.setUserinfo(
              UserModel.fromJson(commonResponse.data!['userInfo']),
            );
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

  Future<Either<String, String>> register({
    required String email,
    required String password,
    required String lastName,
    required String firstName,
    required String role,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: UserEndPoints.register,
        body: {
          'email': email,
          'userName': "$firstName $lastName",
          'password': password,
          'role': role,
        },
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.POST,
        ),
      ).then((response) {
        if (response != null) {
          CommonResponse<Map<String, dynamic>> commonResponse =
              CommonResponse.fromJson(response);
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

  Future<Either<String, String>> logout() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: UserEndPoints.logout,
        headers: NetworkConfig.getHeaders(
          needAuth: true,
          type: RequestType.POST,
        ),
        body: {},
      ).then((response) {
        if (response != null) {
          log('==========> $response');
          CommonResponse<Map<String, dynamic>> commonResponse =
              CommonResponse.fromJson(response);
          if (commonResponse.getStatus) {
            storage.clearPreference();
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

  Future<Either<String, String>> sendCode({required String code}) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: UserEndPoints.sendCode,
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.POST,
        ),
        body: {'code': code},
      ).then((response) {
        if (response != null) {
          log('==========> $response');
          CommonResponse<Map<String, dynamic>> commonResponse =
              CommonResponse.fromJson(response);
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

  Future<Either<String, String>> verifyEmail({required String email}) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: UserEndPoints.verifyEmail,
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.POST,
        ),
        body: {'email': email},
      ).then((response) {
        if (response != null) {
          CommonResponse<Map<String, dynamic>> commonResponse =
              CommonResponse.fromJson(response);
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

  Future<Either<String, String>> resetPassword({
    required String newPassword,
    required String email,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: UserEndPoints.resetPassword,
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.POST,
        ),
        body: {'newPassword': newPassword, 'email': email},
      ).then((response) {
        if (response != null) {
          CommonResponse<Map<String, dynamic>> commonResponse =
              CommonResponse.fromJson(response);
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
  // Future<Either<String, String>> verifyResetPassword({
  //   required String code,
  //   required String email,
  // }) async {
  //   try {
  //     return NetworkUtil.sendRequest(
  //       type: RequestType.POST,
  //       url: UserEndPoints.verifyResetPassword,
  //       headers: NetworkConfig.getHeaders(
  //         needAuth: false,
  //         type: RequestType.POST,
  //       ),
  //       body: {'code': code, 'email': email},
  //     ).then((response) {
  //       if (response != null) {
  //         CommonResponse<Map<String, dynamic>> commonResponse =
  //             CommonResponse.fromJson(response);
  //         if (commonResponse.getStatus) {
  //           return Right(commonResponse.data!['message']);
  //         } else {
  //           return Left(commonResponse.message ?? '');
  //         }
  //       } else {
  //         return Left(tr('Please check your internet'));
  //       }
  //     });
  //   } catch (e) {
  //     return Left(e.toString());
  //   }
  // }

  //

  //

  //

  //

  //
  // Future<Either<String, String>> editProfile({
  //   required String lastName,
  //   required String firstName,
  //   required String carNumber,
  //   required String carModel,
  //   required String carType,
  // }) async {
  //   try {
  //     return NetworkUtil.sendRequest(
  //       type: RequestType.POST,
  //       url: UserEndPoints.editProfile,
  //       body: {
  //         'lastName': lastName,
  //         'firstName': firstName,
  //         'username': storage.getUserInfo()!.username,
  //         'newusername': firstName,
  //         'carNumber': carNumber,
  //         'carModel': carModel,
  //         'carType': carType,
  //       },
  //       headers:
  //           NetworkConfig.getHeaders(needAuth: false, type: RequestType.POST),
  //     ).then((response) {
  //       if (response != null) {
  //         CommonResponse<Map<String, dynamic>> commonResponse =
  //             CommonResponse.fromJson(response);
  //         if (commonResponse.getStatus) {
  //           return Right(commonResponse.data!['message']);
  //         } else {
  //           return Left(commonResponse.message ?? '');
  //         }
  //       } else {
  //         return Left(tr('Please check your internet'));
  //       }
  //     });
  //   } catch (e) {
  //     return Left(e.toString());
  //   }
  // }
}
