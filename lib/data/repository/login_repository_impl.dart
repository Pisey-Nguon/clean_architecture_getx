import 'package:clean_architecture_getx/data/datasource/api_datasource.dart';
import 'package:clean_architecture_getx/domain/entities/body/login_body_with_password.dart';
import 'package:clean_architecture_getx/domain/entities/response/login_response.dart';
import 'package:clean_architecture_getx/domain/entities/result/login_result.dart';
import 'package:clean_architecture_getx/domain/repository/login_repository.dart';
import 'package:clean_architecture_getx/utils/api_helper.dart';

import '../../base/base_result.dart';

class LoginRepositoryImpl extends LoginRepository {
  final ApiDataSource _apiDataSource;

  LoginRepositoryImpl({required ApiDataSource apiDataSource})
      : _apiDataSource = apiDataSource;

  @override
  Future<LoginResult> loginWithPassword({required LoginBodyWithPassword loginBodyWithPassword}) async {
    var loginResult = LoginResult();
    try {
      final apiResponse = await _apiDataSource.loginWithPassword(loginBodyWithPassword: loginBodyWithPassword);
      loginResult.requestStatus =
          ApiHelper.errorHandler(apiResponse: apiResponse);
      switch (loginResult.requestStatus) {
        case RequestStatus.loading:
          break;
        case RequestStatus.success:
          loginResult.successResponse =
              LoginResponse.fromJson(apiResponse.body);
          break;
        case RequestStatus.noInternet:
          break;
        case RequestStatus.failed:
          loginResult.errorResponse = ErrorResponse.fromJson(apiResponse.body);
          break;
        case RequestStatus.somethingWentWrong:
          break;
      }
    } catch (e) {
      _apiDataSource.printErrorService(e.toString());
      loginResult.requestStatus = RequestStatus.somethingWentWrong;
    }

    return loginResult;
  }
}
