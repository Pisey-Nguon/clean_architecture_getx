import 'package:clean_architecture_getx/domain/entities/query/employee_query.dart';
import 'package:clean_architecture_getx/domain/entities/response/data_profile_info.dart';
import 'package:clean_architecture_getx/domain/entities/result/employee_result.dart';
import 'package:clean_architecture_getx/domain/usecase/employee_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../base/base_result.dart';

class EmployeeController extends GetxController{
  final EmployeeUseCase _employeeUseCase;


  EmployeeController({required EmployeeUseCase employeeUseCase})
      : _employeeUseCase = employeeUseCase;

  final box = GetStorage();
  final PagingController<int,DataProfileInfo> pagingController = PagingController(firstPageKey: 0);
  static const pageSize = 10;
  var employeeResult = EmployeeResult();
  var dataProfileInfoList = <DataProfileInfo>[];
  var requestPage = 0;


  Future<void> getEmployeeProfiles(int pageKey) async {
    requestPage += 1;
    var employeeQuery = EmployeeQuery(page: requestPage,perPage: pageSize);
    employeeResult = await _employeeUseCase.getEmployee(employeeQuery: employeeQuery);

    switch(employeeResult.requestStatus){

      case RequestStatus.loading:
        break;
      case RequestStatus.success:
        dataProfileInfoList.addAll(employeeResult.successResponse!.data!);
        var isLastPage = employeeResult.successResponse!.data!.length < pageSize;
        if(isLastPage){
          pagingController.appendLastPage(employeeResult.successResponse!.data!);
        }else{
          final nextPageKey = pageKey + employeeResult.successResponse!.data!.length;
          pagingController.appendPage(employeeResult.successResponse!.data!,nextPageKey);
        }
        break;
      case RequestStatus.noInternet:
        pagingController.error = employeeResult;
        break;
      case RequestStatus.failed:
        pagingController.error = employeeResult;
        break;
      case RequestStatus.somethingWentWrong:
        pagingController.error = employeeResult;
        break;
    }
  }

  void makeError(){
    var result = EmployeeResult();
    result.requestStatus = RequestStatus.failed;
    result.errorResponse = ErrorResponse(error: "This is error");
    pagingController.error = result;
  }

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      Future.delayed(const Duration(seconds: 2),(){
        getEmployeeProfiles(pageKey);
      });

    });
    super.onInit();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }

}
