import 'package:clean_architecture_getx/domain/entities/query/employee_delay_query.dart';
import 'package:clean_architecture_getx/domain/entities/query/employee_query.dart';
import 'package:clean_architecture_getx/domain/entities/response/data_profile_info.dart';
import 'package:clean_architecture_getx/domain/entities/result/employee_result.dart';
import 'package:clean_architecture_getx/domain/usecase/employee_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paginator_ns/flutter_paginator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../base/base_result.dart';

class EmployeeController extends GetxController{
  final EmployeeUseCase _employeeUseCase;


  EmployeeController({required EmployeeUseCase employeeUseCase})
      : _employeeUseCase = employeeUseCase;

  final GlobalKey<PaginatorState> paginateGlobalKey = GlobalKey();
  final box = GetStorage();
  final PagingController<int,DataProfileInfo> pagingController = PagingController(firstPageKey: 0);
  static const pageSize = 10;
  var employeeResult = EmployeeResult();
  var dataProfileInfoList = <DataProfileInfo>[];
  var requestPage = 0;


  List<DataProfileInfo> listItemsGetter(EmployeeResult employeeResult) {
    List<DataProfileInfo> list = [];
    employeeResult.successResponse?.data?.forEach((value) {
      list.add(value);
    });
    return list;
  }



  int totalItem(EmployeeResult employeeResult){
    if(employeeResult.successResponse != null){
      return employeeResult.successResponse!.total!;
    }else{
      return 0;
    }
  }

  bool pageErrorChecker(EmployeeResult employeeResult){
    if(employeeResult.requestStatus == RequestStatus.success){
      return false;
    }else{
      return true;
    }
  }

  Future<void> getEmployeeProfiles(int pageKey) async {
    requestPage += 1;
    var employeeQuery = EmployeeQuery(page: requestPage,perPage: pageSize);
    employeeResult = await _employeeUseCase.getEmployee(employeeQuery: employeeQuery);
    dataProfileInfoList.addAll(employeeResult.successResponse!.data!);
    switch(employeeResult.requestStatus){

      case RequestStatus.loading:
        break;
      case RequestStatus.success:
        var isLastPage = employeeResult.successResponse!.data!.length < pageSize;
        if(isLastPage){
          pagingController.appendLastPage(employeeResult.successResponse!.data!);
        }else{
          final nextPageKey = pageKey + employeeResult.successResponse!.data!.length;
          pagingController.appendPage(employeeResult.successResponse!.data!, nextPageKey);
        }
        break;
      case RequestStatus.noInternet:
        break;
      case RequestStatus.failed:
        // TODO: Handle this case.
        break;
      case RequestStatus.somethingWentWrong:
        // TODO: Handle this case.
        break;
    }
    if(employeeResult.requestStatus == RequestStatus.success){

    }
  }

  @override
  void onInit() {
    pagingController.error = "dd";
    pagingController.addPageRequestListener((pageKey) {
      Future.delayed(const Duration(seconds: 3),(){
        getEmployeeProfiles(pageKey);
      });

    });
    super.onInit();
  }
  @override
  void onReady() {
    super.onReady();
  }
  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }

}
