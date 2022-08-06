import 'package:get/get_connect/connect.dart';

class BaseService extends GetConnect {
  @override
  void onInit() {    // add your local storage here to load for every request
    var token = "dd";
    httpClient.baseUrl = "http://base_url here";    //2.
    httpClient.defaultContentType = "application/json";
    httpClient.timeout = Duration(seconds: 8);
    httpClient.addResponseModifier((request, response) async {
      print(response.body);
    });
    httpClient.addRequestModifier((request) async {
      // add request here
      print(request.headers);
      return request;
    });

    var headers = {'Authorization': "Bearer $token"};
    httpClient.addAuthenticator((request) async {
      request.headers.addAll(headers);
      return request;
    });

    super.onInit();
  }

  dynamic errorHandler(Response response) {
    print(response.toString());
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        var responseJson = response.body;
        return responseJson;
      case 500:
        throw "Server Error pls retry later";
      case 403:
        throw 'Error occurred pls check internet and retry.';
      case 500:
      default:
        throw 'Error occurred retry';
    }
  }
}