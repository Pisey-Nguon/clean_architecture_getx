import 'package:clean_architecture_getx/bases/base_result.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class ApiHelper{
  static final ApiHelper _apiHelper = ApiHelper._internal();
  factory ApiHelper(){
    return _apiHelper;
  }
  static RequestStatus errorHandler({required Response apiResponse}) {
    switch (apiResponse.statusCode) {
      case 200:
      case 201:
      case 202:
        return RequestStatus.success;
      case 500:
        return RequestStatus.failed;
      case 403:
        return RequestStatus.noInternet;
      default:
        return RequestStatus.failed;
    }
  }

  ApiHelper._internal();


}