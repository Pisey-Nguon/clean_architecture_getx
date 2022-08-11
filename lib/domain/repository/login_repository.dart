import 'package:clean_architecture_getx/domain/entities/body/login_body_with_password.dart';
import 'package:clean_architecture_getx/domain/entities/result/login_result.dart';

abstract class LoginRepository {
  Future<LoginResult> loginWithPassword({required LoginBodyWithPassword loginBodyWithPassword});
}
