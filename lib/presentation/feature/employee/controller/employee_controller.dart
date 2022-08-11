import 'package:clean_architecture_getx/domain/entities/employee_params.dart';
import 'package:clean_architecture_getx/domain/entities/employee_query_delay.dart';
import 'package:clean_architecture_getx/domain/entities/employee_response.dart';
import 'package:clean_architecture_getx/domain/entities/employee_result.dart';
import 'package:clean_architecture_getx/domain/usecase/employee_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paginator_ns/flutter_paginator.dart';
import 'package:get/get.dart';

import '../../../../base/base_result.dart';

class EmployeeController extends GetxController{
  final EmployeeUseCase _employeeUseCase;


  EmployeeController({required EmployeeUseCase employeeUseCase})
      : _employeeUseCase = employeeUseCase;

  final GlobalKey<PaginatorState> paginateGlobalKey = GlobalKey();


  List<EmployeeProfile> listItemsGetter(EmployeeResult employeeResult) {
    List<EmployeeProfile> list = [];
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
    var params = EmployeeParams();
    params.employeeType = EmployeeType.getUserDelay;
    params.employeeQueryDelay = EmployeeQueryDelay(page: page,perPage: 6,delay: 3);
    return await _employeeUseCase.call(params);
  }

}
