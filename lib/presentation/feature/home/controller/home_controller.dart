import 'package:clean_architecture_getx/domain/entities/login_body_with_password.dart';
import 'package:clean_architecture_getx/domain/entities/login_params.dart';
import 'package:clean_architecture_getx/domain/usecase/login_usecase.dart';
import 'package:clean_architecture_getx/routes/app_routes.dart';
import 'package:clean_architecture_getx/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../domain/entities/login_result.dart';
import '../../../../base/base_result.dart';

class HomeController extends GetxController{

  LoginUseCase _loginUseCase;
  HomeController({required LoginUseCase loginUseCase}):_loginUseCase = loginUseCase;

  final headerText = "Welcome to clean architecture of Jan Roffer".obs;

  var emailEditController = TextEditingController();
  var passwordEditController = TextEditingController();

  final box = GetStorage();

  final formKey = GlobalKey<FormState>();
  var rememberValue = false;

  @override
  void onInit() {
    emailEditController.text = "eve.holt@reqres.in";
    passwordEditController.text = "cityslicka";
    super.onInit();
  }

  Future<void> loginWithPassword() async {
    Get.defaultDialog(
        title: "Loading",
        content: const CircularProgressIndicator()
    );
    var loginParams = LoginParams();
    loginParams.loginType = LoginType.loginWithPassword;
    loginParams.loginBodyWithPassword = LoginBodyWithPassword(email: emailEditController.value.text,password: passwordEditController.value.text);
    final LoginResult loginResult = await _loginUseCase.call(loginParams);
    switch(loginResult.requestStatus){

      case RequestStatus.success:
        Get.back();
        box.write(Constants.keyToken, loginResult.successResponse!.token);
        Future.delayed(const Duration(milliseconds: 500),(){
          Get.toNamed(AppRoutes.employee);
        });
        break;
      case RequestStatus.noInternet:
        headerText.value = "No Internet";
        Get.back();
        break;
      case RequestStatus.failed:
        headerText.value = loginResult.errorResponse!.error!;
        Get.back();
        break;
      case RequestStatus.somethingWentWrong:
        headerText.value = "Something went wrong";
        Get.back();
        break;
    }
  }
}