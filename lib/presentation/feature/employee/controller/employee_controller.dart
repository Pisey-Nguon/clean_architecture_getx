import 'package:clean_architecture_getx/domain/entities/query/employee_delay_query.dart';
import 'package:clean_architecture_getx/domain/entities/response/data_profile_info.dart';
import 'package:clean_architecture_getx/domain/entities/result/employee_result.dart';
import 'package:clean_architecture_getx/domain/usecase/employee_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paginator_ns/flutter_paginator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../base/base_result.dart';

class EmployeeController extends GetxController{
  final EmployeeUseCase _employeeUseCase;


  EmployeeController({required EmployeeUseCase employeeUseCase})
      : _employeeUseCase = employeeUseCase;

  final GlobalKey<PaginatorState> paginateGlobalKey = GlobalKey();
  final box = GetStorage();


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

  Future<EmployeeResult> getEmployeeProfiles(int page) async {
    var employeeDelayQuery = EmployeeDelayQuery(page: page,perPage: 6,delay: 3);
    return await _employeeUseCase.getEmployeeDelay(employeeDelayQuery: employeeDelayQuery);
  }

}
