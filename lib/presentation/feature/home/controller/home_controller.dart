import 'package:clean_architecture_getx/domain/entities/body/login_body_with_password.dart';
import 'package:clean_architecture_getx/domain/usecase/login_usecase.dart';
import 'package:clean_architecture_getx/routes/app_routes.dart';
import 'package:clean_architecture_getx/assets/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../base/base_result.dart';
import '../../../../domain/entities/result/login_result.dart';

class HomeController extends GetxController {
  final LoginUseCase _loginUseCase;
  HomeController({required LoginUseCase loginUseCase})
      : _loginUseCase = loginUseCase;

  final formKey = GlobalKey<FormState>();
  final box = GetStorage();

  var headerText = "Welcome to clean architecture of Jan Roffer";
  var rememberValue = false;
  var emailEditController = TextEditingController();
  var passwordEditController = TextEditingController();


  @override
  void onInit() {
    emailEditController.text = "eve.holt@reqres.in";
    passwordEditController.text = "cityslicka";
    super.onInit();
  }

  Future<void> loginWithPassword() async {
    Get.defaultDialog(title: "Loading", content: const CircularProgressIndicator());
    var loginBodyWithPassword = LoginBodyWithPassword(
        email: emailEditController.value.text,
        password: passwordEditController.value.text);
    final LoginResult loginResult = await _loginUseCase.password(loginBodyWithPassword: loginBodyWithPassword);
    switch (loginResult.requestStatus!) {
      case RequestStatus.success:
        Get.back();
        box.write(Constants.keyToken, loginResult.successResponse!.token);
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.toNamed(AppRoutes.employee);
        });
        break;
      case RequestStatus.noInternet:
        headerText = "No Internet";
        Get.back();
        break;
      case RequestStatus.failed:
        headerText = loginResult.errorResponse!.error;
        Get.back();
        break;
      case RequestStatus.somethingWentWrong:
        headerText = "Something went wrong";
        Get.back();
        break;
    }
    update();
  }
}
