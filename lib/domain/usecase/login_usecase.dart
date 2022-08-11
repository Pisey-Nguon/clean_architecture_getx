import 'package:clean_architecture_getx/domain/entities/body/login_body_with_password.dart';
import 'package:clean_architecture_getx/domain/repository/login_repository.dart';

import '../entities/result/login_result.dart';

class LoginUseCase {
  final LoginRepository _loginRepository;

  LoginUseCase({required LoginRepository loginRepository})
      : _loginRepository = loginRepository;

  Future<LoginResult> password({required LoginBodyWithPassword loginBodyWithPassword}) async{
    return await _loginRepository.loginWithPassword(loginBodyWithPassword: loginBodyWithPassword);
  }
}
