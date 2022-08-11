import '../entities/result/employee_details_result.dart';

abstract class EmployeeDetailsRepository{
  Future<EmployeeDetailsResult> getEmployeeDetails({required String employeeId});
}