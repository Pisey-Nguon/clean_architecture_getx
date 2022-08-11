import 'package:clean_architecture_getx/domain/entities/query/employee_delay_query.dart';
import 'package:clean_architecture_getx/domain/entities/query/employee_query.dart';
import 'package:clean_architecture_getx/domain/entities/result/employee_result.dart';
import 'package:clean_architecture_getx/domain/repository/employee_repository.dart';

class EmployeeUseCase {
  final EmployeeRepository _employeeRepository;

  EmployeeUseCase({required EmployeeRepository employeeRepository})
      : _employeeRepository = employeeRepository;


  Future<EmployeeResult> getEmployee({required EmployeeQuery employeeQuery}) async {
    return await _employeeRepository.getEmployee(employeeQuery: employeeQuery);
  }
  Future<EmployeeResult> getEmployeeDelay({required EmployeeDelayQuery employeeDelayQuery}) async {
    return await _employeeRepository.getEmployeeDelay(employeeQueryDelay: employeeDelayQuery);
  }
}
