import 'package:clean_architecture_getx/domain/entities/login_result.dart';
import 'package:clean_architecture_getx/domain/entities/login_body_with_password.dart';
import 'package:get/get.dart';

import '../entities/login_response.dart';

abstract class LoginRepository{
  Future<LoginResult> loginWithPassword({required LoginBodyWithPassword body});
}