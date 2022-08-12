import 'package:clean_architecture_getx/base/base_result.dart';
import 'package:clean_architecture_getx/domain/entities/result/employee_details_result.dart';
import 'package:clean_architecture_getx/domain/usecase/employee_details_usecase.dart';
import 'package:get/get.dart';


class EmployeeDetailsController extends GetxController {
  final EmployeeDetailsUseCase _employeeDetailsUseCase;

  EmployeeDetailsController({required EmployeeDetailsUseCase employeeDetailsUseCase}):_employeeDetailsUseCase = employeeDetailsUseCase;
  var id = Get.arguments as int;
  var employeeDetailsResult = EmployeeDetailsResult();


  void reloadGetEmployeeDetails(){
    employeeDetailsResult.requestStatus = RequestStatus.loading;
    update();
    getEmployeeDetails();
  }
  Future<void> getEmployeeDetails() async{
    employeeDetailsResult = await _employeeDetailsUseCase.getEmployeeDetails(employeeId: id.toString());
    update();
  }

  @override
  void onReady() {
    getEmployeeDetails();
    super.onReady();
  }
}