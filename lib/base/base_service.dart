import 'dart:convert';

import 'package:clean_architecture_getx/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

class BaseService extends GetConnect {
  final box = GetStorage();
  final _logger = Logger();

  @override
  void onInit() {
    // add your local storage here to load for every request
    var token = box.read(Constants.keyToken);
    httpClient.baseUrl = "https://reqres.in/";
    httpClient.defaultContentType = "application/json";
    httpClient.timeout = const Duration(seconds: 8);

    httpClient.addResponseModifier((request, response) async {
      if(kDebugMode){
        _logger.i("Url service:\n${request.url} \nResponse: \n${_getPrettyJSONString(response.body)}");
      }
      return response;
    });

    var headers = {'Authorization': "Bearer $token"};
    httpClient.addAuthenticator((Request request) async {
      request.headers.addAll(headers);
      return request;
    });

    super.onInit();
  }
  String _getPrettyJSONString(jsonObject){
    var encoder = const JsonEncoder.withIndent(" ");
    return encoder.convert(jsonObject);
  }

  void printQuery(Map<String,dynamic> query){
    if(kDebugMode) _logger.i("Query Param\n${_getPrettyJSONString(query)}");
  }
  void printBody(Map<String, dynamic> body){
    if(kDebugMode) _logger.i("Body Param\n${_getPrettyJSONString(body)}");
  }
  void printErrorService(String e){
    if(kDebugMode) _logger.i("Error Service \n$e");
  }

}
