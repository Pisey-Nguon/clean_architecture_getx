import 'package:clean_architecture_getx/domain/entities/query/employee_delay_query.dart';
import 'package:clean_architecture_getx/domain/entities/query/employee_query.dart';
import 'package:clean_architecture_getx/domain/entities/result/employee_result.dart';

abstract class EmployeeRepository {
  Future<EmployeeResult> getEmployee({required EmployeeQuery employeeQuery});
  Future<EmployeeResult> getEmployeeDelay({required EmployeeDelayQuery employeeQueryDelay});
}
