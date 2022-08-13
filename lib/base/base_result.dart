
abstract class BaseResult<SuccessResponse> {
  SuccessResponse? successResponse;
  ErrorResponse? errorResponse;
  RequestStatus? requestStatus;
}

enum RequestStatus { success, noInternet, failed, somethingWentWrong }

class ErrorResponse {
  final String error;

  ErrorResponse({required this.error});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(error: json['error']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    return data;
  }
}