import 'package:clean_architecture_getx/base/base_service.dart';
import 'package:clean_architecture_getx/domain/entities/employee_query.dart';
import 'package:clean_architecture_getx/domain/entities/login_body_with_password.dart';
import 'package:get/get.dart';

class ApiDataSource extends BaseService {

  Future<Response<dynamic>> loginWithPassword({required LoginBodyWithPassword loginBodyWithPassword})async{
    return await post("api/login", loginBodyWithPassword.toJson());
  }

  Future<Response> getEmployee({required EmployeeQuery employeeQuery}) async {
    return await get("api/users", query: employeeQuery.toJson());
  }
}
