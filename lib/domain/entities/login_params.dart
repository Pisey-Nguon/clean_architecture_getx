import 'package:clean_architecture_getx/domain/entities/login_body_with_password.dart';

class LoginParams {
  late LoginType loginType;
  late LoginBodyWithPassword loginBodyWithPassword;
}

enum LoginType{
  loginWithPassword
}