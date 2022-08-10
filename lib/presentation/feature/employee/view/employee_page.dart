import 'package:clean_architecture_getx/domain/entities/employee_response.dart';
import 'package:clean_architecture_getx/domain/entities/employee_result.dart';
import 'package:clean_architecture_getx/presentation/feature/employee/controller/employee_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paginator_ns/flutter_paginator.dart';
import 'package:get/get.dart';

import '../../../../base/base_result.dart';

class EmployeePage extends StatelessWidget {
  const EmployeePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: GetBuilder<EmployeeController>(
          init: EmployeeController(employeeUseCase: Get.find()),
          builder: (EmployeeController controller) {
            return SizedBox(
              child: Paginator.listView(
                  pageLoadFuture: (page) async {
                    return controller.getEmployeeProfiles(page);
                  },
                  pageItemsGetter: (EmployeeResult employeeResult) {
                    return controller.listItemsGetter(employeeResult);
                  },
                  listItemBuilder: (dynamic val ,int index) {
                    return _itemEmployeeProfile(controller,val,index);
                  },
                  loadingWidgetBuilder: () =>  _loadingRequestEmployeeWidget(),
                  errorWidgetBuilder: (EmployeeResult employeeResult, _) => _errorRequestEmployeeWidget(employeeResult),
                  emptyListWidgetBuilder: (employeeResult) => _emptyRequestEmployeeWidget(),
                  totalItemsGetter: (EmployeeResult employeeResult) =>
                      controller.totalItem(employeeResult),
                  pageErrorChecker: (EmployeeResult employeeResult) =>
                      controller.pageErrorChecker(employeeResult)),
            );
          }),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Employee"),
    );
  }

  // Widget _buildBody() {
  //   return Container(
  //     child: Obx(() {
  //       return Paginator.listView(
  //           pageLoadFuture: (page) async {
  //             return controller.employeeResult.value;
  //           },
  //           pageItemsGetter: (EmployeeResult employeeResult) {
  //             return controller.listItemsGetter(employeeResult);
  //           },
  //           listItemBuilder: _itemEmployeeProfile,
  //           loadingWidgetBuilder: () => Center(
  //                 child: CircularProgressIndicator(),
  //               ),
  //           errorWidgetBuilder: (employeeResult, dd) => Center(
  //                 child: Text("error"),
  //               ),
  //           emptyListWidgetBuilder: (employeeResult) => Center(
  //                 child: Text("Empty"),
  //               ),
  //           totalItemsGetter: (EmployeeResult employeeResult) =>
  //               controller.totalItem(employeeResult),
  //           pageErrorChecker: (EmployeeResult employeeResult) =>
  //               controller.pageErrorChecker(employeeResult));
  //     }),
  //   );
  // }

  Widget _itemEmployeeProfile(EmployeeController controller,dynamic value, int index) {
    var employeeProfile = value as EmployeeProfile;
    return InkWell(
      onTap: () {},
      child: SizedBox(
          height: 200,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 140,
                    height: 140,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(employeeProfile.avatar.toString()),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Id = ${employeeProfile.id}'),
                      Text('${employeeProfile.firstName} ${employeeProfile.lastName}'),
                      Text(employeeProfile.email.toString())
                    ],
                  )
                ]),
              ),
              Container(
                color: Colors.black12,
                width: Get.width,
                height: 1,
              )
            ],
          )),
    );
  }

  Widget _loadingRequestEmployeeWidget(){
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: const CircularProgressIndicator(),
      ),
    );
  }

  Widget _errorRequestEmployeeWidget(EmployeeResult employeeResult){
    switch(employeeResult.requestStatus){

      case RequestStatus.success:
        return const SizedBox();
      case RequestStatus.noInternet:
        return const Center(child: Text("No internet"),);
      case RequestStatus.failed:
        return Center(child: Text(employeeResult.errorResponse!.error.toString()),);
      case RequestStatus.somethingWentWrong:
        return const Center(child: Text("Something went wrong"),);
    }
  }

  Widget _emptyRequestEmployeeWidget(){
    return const Center(child: Text("Empty"),);
  }
}
