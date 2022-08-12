import 'package:clean_architecture_getx/domain/entities/result/employee_details_result.dart';
import 'package:clean_architecture_getx/presentation/component/view/state_widget_builder.dart';
import 'package:clean_architecture_getx/presentation/feature/employee_details/controller/employee_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeDetailsPage extends StatelessWidget {
  const EmployeeDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmployeeDetailsController>(
      builder: (controller) {
        return Scaffold(
          appBar: _buildAppBar(controller: controller),
          body: _buildBody(controller: controller),
        );
      }
    );
  }

  AppBar _buildAppBar({required EmployeeDetailsController controller}) {
    return AppBar(
      title: const Text("Employee Details"),
      actions: [
        IconButton(
            onPressed: () {
              controller.reloadGetEmployeeDetails();
            },
            icon: const Icon(Icons.refresh))
      ],
    );
  }

  Widget _buildBody({required EmployeeDetailsController controller}) {
    return StateWidgetBuilder<EmployeeDetailsResult>(
      result: controller.employeeDetailsResult,
      retry: (){
        controller.getEmployeeDetails();
      },
      successWidget: (result){
        return _columnDetails(result);
      },
      failedWidget: (errorResponse){
        return _errorWidget(errorResponse.error);
      },
    );
  }

  Widget _columnDetails(EmployeeDetailsResult state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Center(
            child: SizedBox(
              width: Get.width * 0.5,
              height: Get.width * 0.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  state.successResponse!.data!.avatar.toString(),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "First name: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    state.successResponse!.data!.firstName.toString(),
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Last name: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    state.successResponse!.data!.lastName.toString(),
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Email: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    state.successResponse!.data!.email.toString(),
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _loadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _errorWidget(String e) {
    return Center(
      child: Text(e),
    );
  }

  Widget _userNotFound() {
    return const Center(
      child: Text("User not found."),
    );
  }
}
