import 'package:clean_architecture_getx/domain/entities/login_params.dart';
import 'package:clean_architecture_getx/domain/repository/login_repository.dart';
import 'package:clean_architecture_getx/base/base_usecase.dart';

import '../entities/login_result.dart';

abstract class LoginUseCase extends BaseUseCase<LoginResult,LoginParams>{}

class LoginUseCaseImpl extends LoginUseCase{
  final LoginRepository _loginRepository;

  LoginUseCaseImpl({required LoginRepository loginRepository}):_loginRepository = loginRepository;

  @override
  Future<LoginResult> call(LoginParams params) async {
    var loginResult =  LoginResult();
    switch(params.loginType){

      case LoginType.loginWithPassword:
        loginResult = await _loginRepository.loginWithPassword(body: params.loginBodyWithPassword);
    }
    return loginResult;
  }


}