import 'package:clean_architecture_getx/domain/repository/employee_details_repository.dart';

import '../entities/result/employee_details_result.dart';

class EmployeeDetailsUseCase{
  final EmployeeDetailsRepository _employeeDetailsRepository;

  EmployeeDetailsUseCase({required EmployeeDetailsRepository employeeDetailsRepository}):_employeeDetailsRepository = employeeDetailsRepository;


  Future<EmployeeDetailsResult> getEmployeeDetails({required String employeeId}) async {
    return await _employeeDetailsRepository.getEmployeeDetails(employeeId: employeeId);
  }

}