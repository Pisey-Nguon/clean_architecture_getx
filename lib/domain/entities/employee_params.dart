import 'package:clean_architecture_getx/domain/entities/employee_query.dart';
import 'package:clean_architecture_getx/domain/entities/employee_response.dart';

class EmployeeParams{
  late EmployeeType employeeType;
  late EmployeeQuery employeeQuery;
}

enum EmployeeType{
  getUser
}