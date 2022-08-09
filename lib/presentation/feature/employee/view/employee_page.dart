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
      title: const Text("Employee"),
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
          onLoading: const Center(child: CircularProgressIndicator()),
          onEmpty: const Center(
            child: Text("Empty"),
          ),
          onError: (e) => Center(
                child: Text(e.toString()),
              )),
    );
  }

  Widget _itemEmployeeProfile(EmployeeProfile employeeProfile) {
    return InkWell(
      onTap: (){

      },
      child: SizedBox(
          height: 150,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                    children: [
                      const SizedBox(width: 10,),
                      Container(
                        width: 140,
                        height: 140,
                        child: ClipRRect (
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(employeeProfile.avatar.toString()),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${employeeProfile.firstName} ${employeeProfile.lastName}'),
                          Text(employeeProfile.email.toString())
                        ],
                      )

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
      ),
    );
  }
}
