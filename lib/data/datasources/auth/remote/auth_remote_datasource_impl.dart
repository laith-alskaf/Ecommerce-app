import 'package:simple_e_commerce/core/data/models/common_respons.dart';
import 'package:simple_e_commerce/core/data/network/endpoints/auth_endpoints.dart';
import 'package:simple_e_commerce/core/data/network/network_config.dart';
import 'package:simple_e_commerce/core/enums/request_type.dart';
import 'package:simple_e_commerce/core/error/exceptions.dart';
import 'package:simple_e_commerce/core/params/auth/login_params.dart';
import 'package:simple_e_commerce/core/params/auth/reset_password_params.dart';
import 'package:simple_e_commerce/core/params/auth/send_code_params.dart';
import 'package:simple_e_commerce/core/params/auth/signup_params.dart';
import 'package:simple_e_commerce/core/params/auth/verify_params.dart';
import 'package:simple_e_commerce/core/utils/general_util.dart';
import 'package:simple_e_commerce/core/network/network_utils.dart';
import 'package:simple_e_commerce/data/datasources/auth/remote/auth_remote_datasource.dart';
import 'package:simple_e_commerce/data/models/user_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final NetworkUtil networkUtil;

  AuthRemoteDataSourceImpl({required this.networkUtil});

  @override
  Future<({String token, UserModel userModel})> login({
    required LoginParams loginParams,
  }) async {
    final String endpoint = AuthEndPoints.login;
    try {
      return await NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: endpoint,
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.POST,
        ),
        body: {'email': loginParams.email, 'password': loginParams.password},
      ).then((response) {
        if (response != null) {
          // log('==========> $response');
          CommonResponse<Map<String, dynamic>> commonResponse =
              CommonResponse.fromJson(response);
          if (commonResponse.getStatus) {
            storage.setToken(commonResponse.data!['token']);
            storage.setRole(commonResponse.data!['userInfo']['role']);
            storage.setUserinfo(commonResponse.data!['userInfo']);

            return (
              token: '',
              userModel: UserModel.fromJson(commonResponse.data!['userInfo']),
            );
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
  Future<String> signOut() async {
    final String endpoint = AuthEndPoints.logout;
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
          // log('==========> $response');
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
  Future<String> signUp({required SignUpParams signUpParams}) async {
    final String endpoint = AuthEndPoints.register;
    try {
      return await NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: endpoint,
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.POST,
        ),
        body: {
          'email': signUpParams.email,
          'userName': signUpParams.userName,
          'password': signUpParams.password,
          'role': signUpParams.role,
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
  Future<String> verify({required VerifyParams verifyParams}) async {
    final String endpoint = AuthEndPoints.verifyEmail;
    try {
      return await NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: endpoint,
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.POST,
        ),
        body: {'email': verifyParams.email},
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
  Future<String> sendCode({required SendCodeParams sendCodeParams}) async {
    final String endpoint = AuthEndPoints.sendCode;
    try {
      return await NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: endpoint,
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.POST,
        ),
        body: {'code': sendCodeParams.code},
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
  Future<String> resetPassword({
    required ResetPasswordParams resetPasswordParams,
  }) async {
    final String endpoint = AuthEndPoints.resetPassword;
    try {
      return await NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: endpoint,
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.POST,
        ),
        body: {
          'newPassword': resetPasswordParams.newPassword,
          'email': resetPasswordParams.email,
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
}
