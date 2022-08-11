import 'package:clean_architecture_getx/domain/entities/response/support.dart';

import 'data_profile_info.dart';

class EmployeeDetailsResponse {
  DataProfileInfo? data;
  Support? support;

  EmployeeDetailsResponse({this.data, this.support});

  EmployeeDetailsResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? DataProfileInfo.fromJson(json['data']) : null;
    support =
    json['support'] != null ? Support.fromJson(json['support']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (support != null) {
      data['support'] = support!.toJson();
    }
    return data;
  }
}

