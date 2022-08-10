import 'package:clean_architecture_getx/domain/entities/employee_params.dart';
import 'package:clean_architecture_getx/domain/entities/employee_query.dart';
import 'package:clean_architecture_getx/domain/entities/employee_response.dart';
import 'package:clean_architecture_getx/domain/usecase/employee_usecase.dart';
import 'package:get/get.dart';

import '../../../../base/base_result.dart';

class EmployeeController extends GetxController with StateMixin<List<EmployeeProfile>> {
  final EmployeeUseCase _employeeUseCase;

  List<EmployeeProfile> employeeProfiles = [];

  EmployeeController({required EmployeeUseCase employeeUseCase})
      : _employeeUseCase = employeeUseCase;

  @override
  void onReady() {
    getEmployeeProfiles();
    super.onReady();
  }

  Future<void> getEmployeeProfiles() async {
    change(employeeProfiles, status: RxStatus.loading());
    var params = EmployeeParams();
    params.employeeType = EmployeeType.getUser;
    params.employeeQuery = EmployeeQuery(page: 1, perPage: 1);
    final result = await _employeeUseCase.call(params);
    switch (result.requestStatus) {
      case RequestStatus.success:
        employeeProfiles = result.successResponse!.data!;
        change(employeeProfiles, status: RxStatus.success());
        break;
      case RequestStatus.noInternet:
        change(employeeProfiles, status: RxStatus.error("No internet"));
        break;
      case RequestStatus.failed:
        change(employeeProfiles,
            status: RxStatus.error(result.errorResponse!.error));
        break;
      case RequestStatus.somethingWentWrong:
        change(employeeProfiles,
            status: RxStatus.error("Something went wrong"));
        break;
    }
  }
}
