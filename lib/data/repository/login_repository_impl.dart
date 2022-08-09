import 'package:clean_architecture_getx/data/datasource/api_datasource.dart';
import 'package:clean_architecture_getx/domain/entities/error_response.dart';
import 'package:clean_architecture_getx/domain/entities/login_result.dart';
import 'package:clean_architecture_getx/domain/entities/login_body_with_password.dart';
import 'package:clean_architecture_getx/domain/entities/login_response.dart';
import 'package:clean_architecture_getx/domain/repository/login_repository.dart';
import 'package:clean_architecture_getx/utils/api_helper.dart';

import '../../base/base_result.dart';

class LoginRepositoryImpl extends LoginRepository{

  final ApiDataSource _apiDataSource;

  LoginRepositoryImpl({required ApiDataSource apiDataSource}): _apiDataSource = apiDataSource;

  @override
  Future<LoginResult> loginWithPassword({required LoginBodyWithPassword body}) async {
    var loginResult = LoginResult();
    try{
      final apiResponse  = await _apiDataSource.loginWithPassword(body);
      loginResult.requestStatus = ApiHelper.errorHandler(apiResponse: apiResponse);
      switch(loginResult.requestStatus){

        case RequestStatus.success:
          loginResult.successResponse = LoginResponse.fromJson(apiResponse.body);
          break;
        case RequestStatus.noInternet:

          break;
        case RequestStatus.failed:
          loginResult.errorResponse = ErrorResponse.fromJson(apiResponse.body);
          break;
        case RequestStatus.somethingWentWrong:
          break;
      }
    }catch(_){
      loginResult.requestStatus = RequestStatus.somethingWentWrong;
    }

    return loginResult;
  }





}