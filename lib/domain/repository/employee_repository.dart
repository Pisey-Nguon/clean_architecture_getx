import 'package:clean_architecture_getx/domain/entities/employee_query.dart';
import 'package:clean_architecture_getx/domain/entities/employee_result.dart';

abstract class EmployeeRepository{
  Future<EmployeeResult> getEmployee({required EmployeeQuery query});
}