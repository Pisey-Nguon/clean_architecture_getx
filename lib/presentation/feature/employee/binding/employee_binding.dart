import 'package:clean_architecture_getx/data/repository/employee_repository_impl.dart';
import 'package:clean_architecture_getx/domain/repository/employee_repository.dart';
import 'package:clean_architecture_getx/domain/usecase/employee_usecase.dart';
import 'package:get/get.dart';

class EmployeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<EmployeeRepository>(EmployeeRepositoryImpl(apiDataSource: Get.find()));
    Get.put<EmployeeUseCase>(EmployeeUseCase(employeeRepository: Get.find()));
  }
}
