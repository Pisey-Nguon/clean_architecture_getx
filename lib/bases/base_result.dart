import 'package:clean_architecture_getx/domain/entities/error_response.dart';

abstract class BaseResult<SuccessResponse>{
  SuccessResponse? successResponse;
  ErrorResponse? errorResponse;
  RequestStatus requestStatus = RequestStatus.failed;
}

enum RequestStatus{
  success,
  noInternet,
  failed,
  somethingWentWrong
}