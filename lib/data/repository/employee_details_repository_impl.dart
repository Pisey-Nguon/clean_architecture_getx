import 'package:clean_architecture_getx/data/datasource/api_datasource.dart';
import 'package:clean_architecture_getx/domain/entities/response/employee_details_response.dart';
import 'package:clean_architecture_getx/domain/entities/result/employee_details_result.dart';
import 'package:clean_architecture_getx/domain/repository/employee_details_repository.dart';
import 'package:clean_architecture_getx/utils/api_helper.dart';

import '../../base/base_result.dart';
import '../../domain/entities/response/error_response.dart';

class EmployeeDetailsRepositoryImpl extends EmployeeDetailsRepository{
  final ApiDataSource _apiDataSource;

  EmployeeDetailsRepositoryImpl({required ApiDataSource apiDataSource}):_apiDataSource = apiDataSource;

  @override
  Future<EmployeeDetailsResult> getEmployeeDetails({required String employeeId}) async {
    final employeeDetailsResult = EmployeeDetailsResult();
    try{
      var apiResponse = await _apiDataSource.getEmployeeDetails(employeeId: employeeId);
      employeeDetailsResult.requestStatus = ApiHelper.errorHandler(apiResponse: apiResponse);
      switch(employeeDetailsResult.requestStatus!){

        case RequestStatus.success:
          employeeDetailsResult.successResponse = EmployeeDetailsResponse.fromJson(apiResponse.body);
          break;
        case RequestStatus.noInternet:
          break;
        case RequestStatus.failed:

          employeeDetailsResult.errorResponse = ErrorResponse.fromJson(apiResponse.body);
          break;
        case RequestStatus.somethingWentWrong:
          break;
      }
    }catch (e){
      employeeDetailsResult.requestStatus = RequestStatus.somethingWentWrong;
    }
    return employeeDetailsResult;
  }

}