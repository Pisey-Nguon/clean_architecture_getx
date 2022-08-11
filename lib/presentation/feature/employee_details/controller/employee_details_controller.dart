import 'package:clean_architecture_getx/domain/entities/result/employee_details_result.dart';
import 'package:clean_architecture_getx/domain/usecase/employee_details_usecase.dart';
import 'package:get/get.dart';

import '../../../../base/base_result.dart';

class EmployeeDetailsController extends GetxController with StateMixin<EmployeeDetailsResult>{
  final EmployeeDetailsUseCase _employeeDetailsUseCase;

  EmployeeDetailsController({required EmployeeDetailsUseCase employeeDetailsUseCase}):_employeeDetailsUseCase = employeeDetailsUseCase;
  var id = Get.arguments as int;
  @override
  void onInit() {
    getEmployeeDetails(employeeId: id.toString());
    super.onInit();
  }

  void reloadPage(){
    getEmployeeDetails(employeeId: id.toString());
  }
  Future<void> getEmployeeDetails({required String employeeId}) async{
    change(null,status: RxStatus.loading());
    final employeeDetailsResult = await _employeeDetailsUseCase.getEmployeeDetails(employeeId: employeeId);
    switch(employeeDetailsResult.requestStatus){

      case RequestStatus.success:
        change(employeeDetailsResult,status: RxStatus.success());
        break;
      case RequestStatus.noInternet:
        change(employeeDetailsResult,status: RxStatus.error("No internet"));
        break;
      case RequestStatus.failed:
        change(employeeDetailsResult,status: RxStatus.error(employeeDetailsResult.errorResponse!.error));
        break;
      case RequestStatus.somethingWentWrong:
        change(null,status: RxStatus.error("Something went wrong"));
        break;
    }

  }
}