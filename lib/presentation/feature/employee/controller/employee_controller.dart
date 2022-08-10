import 'package:clean_architecture_getx/domain/entities/employee_params.dart';
import 'package:clean_architecture_getx/domain/entities/employee_query.dart';
import 'package:clean_architecture_getx/domain/entities/employee_response.dart';
import 'package:clean_architecture_getx/domain/usecase/employee_usecase.dart';
import 'package:get/get.dart';

import '../../../../base/base_result.dart';

class EmployeeController extends GetxController with StateMixin<List<EmployeeProfile>>,ScrollMixin {
  final EmployeeUseCase _employeeUseCase;

  var employeeProfiles = RxList<EmployeeProfile>();

  EmployeeController({required EmployeeUseCase employeeUseCase})
      : _employeeUseCase = employeeUseCase;

  final int repositoriesPerPage = 10;
  int page = 1;
  bool getFirstData = false;
  bool lastPage = false;

  @override
  void onInit() {
    getEmployeeProfiles();
    super.onInit();
  }

  Future<void> getEmployeeProfiles() async {
    change(employeeProfiles, status: RxStatus.loading());
    var params = EmployeeParams();
    params.employeeType = EmployeeType.getUser;
    params.employeeQuery = EmployeeQuery(page: page, perPage: repositoriesPerPage);
    final result = await _employeeUseCase.call(params);
    switch (result.requestStatus) {
      case RequestStatus.success:
        employeeProfiles.value = result.successResponse!.data!;
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

  @override
  Future<void> onEndScroll() {

    throw UnimplementedError();
  }

  @override
  Future<void> onTopScroll() {
    // TODO: implement onTopScroll
    throw UnimplementedError();
  }
}
