import 'package:clean_architecture_getx/domain/entities/employee_result.dart';
import 'package:clean_architecture_getx/bases/base_usecase.dart';
import 'package:clean_architecture_getx/bases/base_result.dart';
import 'package:clean_architecture_getx/domain/repository/employee_repository.dart';

import '../entities/employee_params.dart';

abstract class EmployeeUseCase extends BaseUseCase<EmployeeResult,EmployeeParams>{}

class EmployeeUseCaseImpl extends EmployeeUseCase{
  final EmployeeRepository _employeeRepository;

  EmployeeUseCaseImpl({required EmployeeRepository employeeRepository}):_employeeRepository = employeeRepository;
  @override
  Future<EmployeeResult> call(EmployeeParams params) async{
    var employeeResult = EmployeeResult();
    switch(params.employeeType){

      case EmployeeType.getUser:
        employeeResult = await _employeeRepository.getEmployee(query: params.employeeQuery);
        break;
    }
    return employeeResult;
  }

}