import 'package:clean_architecture_getx/domain/entities/response/data_profile_info.dart';
import 'package:clean_architecture_getx/domain/entities/response/support.dart';

class EmployeeResponse {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<DataProfileInfo>? data;
  Support? support;

  EmployeeResponse(
      {this.page,
      this.perPage,
      this.total,
      this.totalPages,
      this.data,
      this.support});

  EmployeeResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['data'] != null) {
      data = <DataProfileInfo>[];
      json['data'].forEach((v) {
        data!.add(DataProfileInfo.fromJson(v));
      });
    }
    support =
        json['support'] != null ? Support.fromJson(json['support']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['per_page'] = perPage;
    data['total'] = total;
    data['total_pages'] = totalPages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (support != null) {
      data['support'] = support!.toJson();
    }
    return data;
  }
}


