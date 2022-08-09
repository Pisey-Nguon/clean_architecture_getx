import 'package:clean_architecture_getx/data/datasource/base_service.dart';
import 'package:clean_architecture_getx/domain/entities/employee_query.dart';
import 'package:clean_architecture_getx/domain/entities/login_body_with_password.dart';
import 'package:get/get.dart';

import '../../domain/entities/login_response.dart';

class ApiDataSource extends BaseService{

  Future<Response<dynamic>> loginWithPassword(LoginBodyWithPassword body) async {
    var response = await post("api/login", body.toJson());
    print(response.statusText);
    return response;
  }

  Future<Response> getEmployee(EmployeeQuery query) async {
    var response =  await get("api/users",query: query.toJson());
    return response;
  }

}