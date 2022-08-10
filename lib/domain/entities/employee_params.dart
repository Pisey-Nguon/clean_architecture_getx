import 'package:clean_architecture_getx/domain/entities/employee_query.dart';

class EmployeeParams {
  late EmployeeType employeeType;
  late EmployeeQuery employeeQuery;
}

enum EmployeeType { getUser }
