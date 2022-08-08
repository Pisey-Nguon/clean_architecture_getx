import 'package:clean_architecture_getx/data/datasource/api_datasource.dart';
import 'package:clean_architecture_getx/domain/entities/employee_query.dart';
import 'package:clean_architecture_getx/domain/entities/employee_response.dart';
import 'package:clean_architecture_getx/domain/entities/employee_result.dart';
import 'package:clean_architecture_getx/domain/repository/employee_repository.dart';
import 'package:clean_architecture_getx/utils/api_helper.dart';

import '../../domain/entities/error_response.dart';
import '../../bases/base_result.dart';

class EmployeeRepositoryImpl extends EmployeeRepository{
  final ApiDataSource _apiDataSource;

  EmployeeRepositoryImpl({required ApiDataSource apiDataSource}):_apiDataSource = apiDataSource;
  @override
  Future<EmployeeResult> getEmployee({required EmployeeQuery query}) async {
    var employeeResult = EmployeeResult();
    final apiResponse = await _apiDataSource.getEmployee(query);
    employeeResult.requestStatus = ApiHelper.errorHandler(apiResponse: apiResponse);
    try{
      switch(employeeResult.requestStatus){

        case RequestStatus.success:
          employeeResult.successResponse = EmployeeResponse.fromJson(apiResponse.body);
          break;
        case RequestStatus.noInternet:
          break;
        case RequestStatus.failed:
          employeeResult.errorResponse = ErrorResponse.fromJson(apiResponse.body);
          break;
        case RequestStatus.somethingWentWrong:
          break;
      }
    }catch(e){
      employeeResult.requestStatus = RequestStatus.somethingWentWrong;
    }

    return employeeResult;
  }

}