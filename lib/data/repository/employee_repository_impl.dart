import 'package:clean_architecture_getx/data/datasource/api_datasource.dart';
import 'package:clean_architecture_getx/domain/entities/query/employee_delay_query.dart';
import 'package:clean_architecture_getx/domain/entities/query/employee_query.dart';
import 'package:clean_architecture_getx/domain/entities/response/employee_response.dart';
import 'package:clean_architecture_getx/domain/entities/result/employee_result.dart';
import 'package:clean_architecture_getx/domain/repository/employee_repository.dart';
import 'package:clean_architecture_getx/utils/api_helper.dart';

import '../../base/base_result.dart';

class EmployeeRepositoryImpl extends EmployeeRepository {
  final ApiDataSource _apiDataSource;

  EmployeeRepositoryImpl({required ApiDataSource apiDataSource})
      : _apiDataSource = apiDataSource;
  @override
  Future<EmployeeResult> getEmployee({required EmployeeQuery employeeQuery}) async {
    _apiDataSource.printQuery(employeeQuery.toJson());
    var employeeResult = EmployeeResult();
    try {
      final apiResponse = await _apiDataSource.getEmployee(employeeQuery: employeeQuery);
      employeeResult.requestStatus = ApiHelper.errorHandler(apiResponse: apiResponse);
      switch (employeeResult.requestStatus) {
        case RequestStatus.success:
          employeeResult.successResponse =
              EmployeeResponse.fromJson(apiResponse.body);
          break;
        case RequestStatus.noInternet:
          break;
        case RequestStatus.failed:
          employeeResult.errorResponse = ErrorResponse.fromJson(apiResponse.body);
          break;
        case RequestStatus.somethingWentWrong:
          break;
      }
    } catch (e) {
      _apiDataSource.printErrorService(e.toString());
      employeeResult.requestStatus = RequestStatus.somethingWentWrong;
    }

    return employeeResult;
  }

  @override
  Future<EmployeeResult> getEmployeeDelay({required EmployeeDelayQuery employeeQueryDelay}) async {
    _apiDataSource.printQuery(employeeQueryDelay.toJson());
    var employeeResult = EmployeeResult();
    try {
      final apiResponse = await _apiDataSource.getEmployeeDelay(employeeQueryDelay: employeeQueryDelay);
      employeeResult.requestStatus = ApiHelper.errorHandler(apiResponse: apiResponse);
      switch (employeeResult.requestStatus) {
        case RequestStatus.success:
          employeeResult.successResponse =
              EmployeeResponse.fromJson(apiResponse.body);
          break;
        case RequestStatus.noInternet:
          break;
        case RequestStatus.failed:
          employeeResult.errorResponse = ErrorResponse.fromJson(apiResponse.body);
          break;
        case RequestStatus.somethingWentWrong:
          break;
      }
    } catch (e) {
      _apiDataSource.printErrorService(e.toString());
      employeeResult.requestStatus = RequestStatus.somethingWentWrong;
    }

    return employeeResult;
  }
}
