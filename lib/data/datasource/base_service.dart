import 'dart:convert';

import 'package:clean_architecture_getx/utils/constants.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

class BaseService extends GetConnect {
  final box = GetStorage();
  @override
  void onInit() {    // add your local storage here to load for every request
    var token = box.read(Constants.keyToken);
    var logger = Logger();
    httpClient.baseUrl = "https://reqres.in/";    //2.
    httpClient.defaultContentType = "application/json";
    httpClient.timeout = const Duration(seconds: 8);


    httpClient.addResponseModifier((request, response) async{
      logger.log(Level.info, request.url);
      logger.log(Level.debug, response.body);
      return response;
    });

    var headers = {'Authorization': "Bearer $token"};
    httpClient.addAuthenticator((Request request) async {
      request.headers.addAll(headers);
      return request;
    });

    super.onInit();
  }
}