import 'package:clean_architecture_getx/base/base_result.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class ApiHelper {
  static final ApiHelper _apiHelper = ApiHelper._internal();
  factory ApiHelper() {
    return _apiHelper;
  }
  static RequestStatus errorHandler({required Response apiResponse}) {
    var status = HttpStatus(apiResponse.statusCode);
    if (status.isOk) {
      return RequestStatus.success;
    } else if (status.isServerError) {
      return RequestStatus.failed;
    } else if (status.isForbidden) {
      return RequestStatus.failed;
    } else if (status.isNotFound) {
      return RequestStatus.failed;
    } else if (status.isUnauthorized) {
      return RequestStatus.failed;
    } else if (status.connectionError) {
      return RequestStatus.noInternet;
    } else {
      return RequestStatus.failed;
    }
  }

  ApiHelper._internal();
}
