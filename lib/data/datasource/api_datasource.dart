import 'package:clean_architecture_getx/base/base_service.dart';
import 'package:clean_architecture_getx/domain/entities/body/login_body_with_password.dart';
import 'package:clean_architecture_getx/domain/entities/query/employee_delay_query.dart';
import 'package:clean_architecture_getx/domain/entities/query/employee_query.dart';
import 'package:get/get.dart';

class ApiDataSource extends BaseService {

  Future<Response<dynamic>> loginWithPassword({required LoginBodyWithPassword loginBodyWithPassword})async{
    return await methodPost("api/login", loginBodyWithPassword.toJson());
  }

  Future<Response> getEmployee({required EmployeeQuery employeeQuery}) async {
    return await methodGet("api/users",query: employeeQuery.toJson());
  }

  Future<Response> getEmployeeDelay({required EmployeeDelayQuery employeeQueryDelay}) async {
    return await methodGet("api/users", query: employeeQueryDelay.toJson());
  }

  Future<Response> getEmployeeDetails({required String employeeId}) async {
    return await methodGet("api/users/$employeeId");
  }
}
