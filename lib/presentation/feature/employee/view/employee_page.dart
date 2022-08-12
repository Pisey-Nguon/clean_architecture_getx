import 'package:clean_architecture_getx/domain/entities/response/data_profile_info.dart';
import 'package:clean_architecture_getx/domain/entities/result/employee_result.dart';
import 'package:clean_architecture_getx/presentation/component/view/state_list_builder.dart';
import 'package:clean_architecture_getx/presentation/component/view_logic/employee_dropdown_enum.dart';
import 'package:clean_architecture_getx/presentation/feature/employee/controller/employee_controller.dart';
import 'package:clean_architecture_getx/routes/app_routes.dart';
import 'package:clean_architecture_getx/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../base/base_result.dart';

class EmployeePage extends StatelessWidget {
  const EmployeePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmployeeController>(
        init: EmployeeController(employeeUseCase: Get.find()),
        builder: (controller) {
          return Scaffold(
              appBar: _buildAppBar(controller), body: _buildBody(controller));
        });
  }

  AppBar _buildAppBar(EmployeeController controller) {
    return AppBar(
      title: const Text("Employee"),
      actions: [
        IconButton(
            onPressed: () {

            },
            icon: const Icon(Icons.list)),
        IconButton(
            onPressed: () {

            },
            icon: const Icon(Icons.grid_view)),
        PopupMenuButton<EmployeeDropDownEnum>(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) {
            switch (value) {
              case EmployeeDropDownEnum.logout:
                Get.defaultDialog(
                    title: "Warning!",
                    middleText: "Are you to logout?",
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text("No")),
                      ElevatedButton(
                          onPressed: () {
                            Get.back();
                            controller.box.remove(Constants.keyToken);
                            Get.back();
                            Get.toNamed(AppRoutes.home);
                          },
                          child: const Text("Yes"))
                    ]);
                break;
            }
          },
          itemBuilder: (BuildContext context) {
            var items = EmployeeDropDownEnum.values.map((e) {
              switch (e) {
                case EmployeeDropDownEnum.logout:
                  return PopupMenuItem<EmployeeDropDownEnum>(
                      value: e, child: const Text("Logout"));
              }
            });
            return items.toList();
          },
        )
      ],
    );
  }

  Widget _buildBody(EmployeeController controller) {
    return StateListBuilder<DataProfileInfo>(
        items: controller.dataProfileInfoList,
        pagingController: controller.pagingController,
        itemBuilder: (context,item,index)=> _itemForListLayout(item,index),
    );

  }

  Widget _itemForListLayout(dynamic itemValue, int index) {
    var employeeProfile = itemValue as DataProfileInfo;
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.employeeDetails, arguments: employeeProfile.id);
      },
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
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        employeeProfile.avatar.toString(),
                        fit: BoxFit.fitHeight,
                      ),
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
                      Text(
                          '${employeeProfile.firstName} ${employeeProfile.lastName}'),
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

  Widget _itemForGridLayout(dynamic itemValue, int index) {
    var employeeProfile = itemValue as DataProfileInfo;
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.employeeDetails, arguments: employeeProfile.id);
      },
      child: SizedBox(
        height: 150,
        width: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            employeeProfile.avatar.toString(),
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }

  Widget _loadingRequestEmployeeWidget() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: const CircularProgressIndicator(),
      ),
    );
  }

  Widget _errorRequestEmployeeWidget(EmployeeResult employeeResult) {
    switch (employeeResult.requestStatus) {
      case RequestStatus.loading:
        return const SizedBox();
      case RequestStatus.success:
        return const SizedBox();
      case RequestStatus.noInternet:
        return const Center(
          child: Text("No internet"),
        );
      case RequestStatus.failed:
        return Center(
          child: Text(employeeResult.errorResponse!.error.toString()),
        );
      case RequestStatus.somethingWentWrong:
        return const Center(
          child: Text("Something went wrong"),
        );
    }
  }

  Widget _emptyRequestEmployeeWidget() {
    return const Center(
      child: Text("Empty"),
    );
  }
}
