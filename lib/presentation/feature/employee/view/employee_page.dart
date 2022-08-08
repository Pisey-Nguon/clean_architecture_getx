import 'package:clean_architecture_getx/domain/entities/employee_response.dart';
import 'package:clean_architecture_getx/presentation/feature/employee/controller/employee_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeePage extends GetView<EmployeeController> {
  const EmployeePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Employee"),
    );
  }

  Widget _buildBody() {
    return Container(
      child: controller.obx(
          (state) => ListView.builder(
                itemCount: state!.length,
                itemBuilder: (context, index) =>
                    _itemEmployeeProfile(state[index]),
              ),
          onLoading: Center(child: CircularProgressIndicator()),
          onEmpty: Center(
            child: Text("Empty"),
          ),
          onError: (e) => Center(
                child: Text(e.toString()),
              )),
    );
  }

  Widget _itemEmployeeProfile(EmployeeProfile employeeProfile) {
    return Container(
        height: 50,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                  children: [
                    SizedBox(width: 10,),
                    Container(
                      width: 40,
                      height: 40,
                      child: ClipRRect (
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(employeeProfile.avatar.toString()),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Text(employeeProfile.firstName.toString())
                  ]
              ),
            ),
            Container(
              color: Colors.black12,
              width: Get.width,
              height: 1,
            )
          ],
        )
    );
  }
}
