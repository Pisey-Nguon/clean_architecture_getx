import 'package:clean_architecture_getx/domain/entities/employee_query.dart';

import 'employee_query_delay.dart';

class EmployeeParams {
  late EmployeeType employeeType;
  late EmployeeQuery employeeQuery;
  late EmployeeQueryDelay employeeQueryDelay;
}

enum EmployeeType {
  getUser ,
  getUserDelay
}
