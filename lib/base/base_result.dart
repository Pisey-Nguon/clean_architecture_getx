
import '../domain/entities/response/error_response.dart';

abstract class BaseResult<T> {
  T? successResponse;
  ErrorResponse? errorResponse;
  RequestStatus? requestStatus;
}

enum RequestStatus { success, noInternet, failed, somethingWentWrong }