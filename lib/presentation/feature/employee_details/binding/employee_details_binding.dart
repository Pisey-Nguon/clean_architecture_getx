import 'package:clean_architecture_getx/data/repository/employee_details_repository_impl.dart';
import 'package:clean_architecture_getx/domain/repository/employee_details_repository.dart';
import 'package:clean_architecture_getx/domain/usecase/employee_details_usecase.dart';
import 'package:get/get.dart';

class EmployeeDetailsBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<EmployeeDetailsRepository>(EmployeeDetailsRepositoryImpl(apiDataSource: Get.find()));
    Get.put<EmployeeDetailsUseCase>(EmployeeDetailsUseCase(employeeDetailsRepository: Get.find()));
  }

}