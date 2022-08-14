import 'dart:convert';

import 'package:clean_architecture_getx/domain/entities/body/refresh_token_body.dart';
import 'package:clean_architecture_getx/domain/entities/response/refresh_token_response.dart';
import 'package:clean_architecture_getx/utils/api_helper.dart';
import 'package:clean_architecture_getx/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

import 'base_result.dart';

class BaseService extends GetConnect {
  final box = GetStorage();
  final _logger = Logger();
  late String _token;

  @override
  void onInit() {
    // add your local storage here to load for every request
    _token = box.read(Constants.keyToken);
    httpClient.baseUrl = "https://reqres.in/";
    httpClient.defaultContentType = "application/json";
    httpClient.timeout = const Duration(seconds: 8);

    httpClient.addResponseModifier((request, response) async {
      if (kDebugMode) {
        _logger.i("Url service:\n${request.url}\nToken: ${request.headers}\nResponse: \n${_getPrettyJSONString(response.body)}");
      }
      return response;
    });

    super.onInit();
  }

  String _getPrettyJSONString(jsonObject) {
    var encoder = const JsonEncoder.withIndent(" ");
    return encoder.convert(jsonObject);
  }

  void printQuery(Map<String, dynamic> query) {
    if (kDebugMode) _logger.i("Query Param\n${_getPrettyJSONString(query)}");
  }

  void printBody(Map<String, dynamic> body) {
    if (kDebugMode) _logger.i("Body Param\n${_getPrettyJSONString(body)}");
  }

  void printErrorService(String e) {
    if (kDebugMode) _logger.i("Error Service \n$e");
  }

  Future<Response<dynamic>> _requestRefreshToken() async {
    var currentToken = box.read(Constants.keyToken);
    var refreshTokenBody = RefreshTokenBody(currentToken: currentToken);
    return await post("api/refresh/token", refreshTokenBody.toJson());
  }

  Future<Response<dynamic>> methodGet(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    Decoder<dynamic>? decoder,
  }) async {
    var currentHeaders = <String, String>{};
    if (headers != null) {
      currentHeaders = headers;
    } else {
      currentHeaders = {"Authorization": _token};
    }
    var response = await get(url,
        headers: currentHeaders,
        contentType: contentType,
        query: query,
        decoder: decoder);
    if (response.unauthorized) {
      var newTokenResponse = await _requestRefreshToken();
      var requestStatus = ApiHelper.errorHandler(apiResponse: newTokenResponse);
      if (requestStatus == RequestStatus.success) {
        var successResponse = RefreshTokenResponse.fromJson(newTokenResponse.body);
        box.write(Constants.keyToken, successResponse.newToken);
        _token = successResponse.newToken;
        var newHeaders = {"Authorization": successResponse.newToken};
        methodGet(url,
            headers: newHeaders,
            contentType: contentType,
            query: query,
            decoder: decoder);
      } else {
        return newTokenResponse;
      }
      return response;
    } else {
      return response;
    }
  }

  Future<Response<dynamic>> methodPost(
    String? url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<dynamic>? decoder,
    Progress? uploadProgress,
  }) async {
    var currentHeaders = <String, String>{};
    if (headers != null) {
      currentHeaders = headers;
    } else {
      currentHeaders = {"Authorization": _token};
    }
    var response = await post(url, body,
        contentType: contentType,
        headers: currentHeaders,
        query: query,
        decoder: decoder,
        uploadProgress: uploadProgress);
    if (response.unauthorized) {
      var newTokenResponse = await _requestRefreshToken();
      var requestStatus = ApiHelper.errorHandler(apiResponse: newTokenResponse);
      if (requestStatus == RequestStatus.success) {
        var successResponse = RefreshTokenResponse.fromJson(newTokenResponse.body);
        box.write(Constants.keyToken, successResponse.newToken);
        _token = successResponse.newToken;
        var newHeaders = {"Authorization": successResponse.newToken};
        methodPost(url, body,
            contentType: contentType,
            headers: newHeaders,
            query: query,
            decoder: decoder,
            uploadProgress: uploadProgress);
      } else {
        return newTokenResponse;
      }
      return response;
    } else {
      return response;
    }
  }

  Future<Response<dynamic>> methodPut(
    String url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<dynamic>? decoder,
    Progress? uploadProgress,
  }) async {
    var currentHeaders = <String, String>{};
    if (headers != null) {
      currentHeaders = headers;
    } else {
      currentHeaders = {"Authorization": _token};
    }
    var response = await put(url, body,
        contentType: contentType,
        headers: currentHeaders,
        query: query,
        decoder: decoder,
        uploadProgress: uploadProgress);
    if (response.unauthorized) {
      var newTokenResponse = await _requestRefreshToken();
      var requestStatus = ApiHelper.errorHandler(apiResponse: newTokenResponse);
      if (requestStatus == RequestStatus.success) {
        var successResponse = RefreshTokenResponse.fromJson(newTokenResponse.body);
        box.write(Constants.keyToken, successResponse.newToken);
        _token = successResponse.newToken;
        var newHeaders = {"Authorization": successResponse.newToken};
        methodPut(url, body,
            contentType: contentType,
            headers: newHeaders,
            query: query,
            decoder: decoder,
            uploadProgress: uploadProgress);
      } else {
        return newTokenResponse;
      }
      return response;
    } else {
      return response;
    }
  }

  Future<Response<dynamic>> methodDelete(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    Decoder<dynamic>? decoder,
  }) async {
    var currentHeaders = <String, String>{};
    if (headers != null) {
      currentHeaders = headers;
    } else {
      currentHeaders = {"Authorization": _token};
    }
    var response = await delete(url,
        headers: currentHeaders,
        contentType: contentType,
        query: query,
        decoder: decoder);
    if (response.unauthorized) {
      var newTokenResponse = await _requestRefreshToken();
      var requestStatus = ApiHelper.errorHandler(apiResponse: newTokenResponse);
      if (requestStatus == RequestStatus.success) {
        var successResponse = RefreshTokenResponse.fromJson(newTokenResponse.body);
        box.write(Constants.keyToken, successResponse.newToken);
        _token = successResponse.newToken;
        var newHeaders = {"Authorization": successResponse.newToken};
        methodDelete(url,
            headers: newHeaders,
            contentType: contentType,
            query: query,
            decoder: decoder);
      } else {
        return newTokenResponse;
      }
      return response;
    } else {
      return response;
    }
  }
}
