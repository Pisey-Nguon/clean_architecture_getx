class EmployeeQuery {
  int? page;

  EmployeeQuery({this.page});

  EmployeeQuery.fromJson(Map<String, dynamic> json) {
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    return data;
  }
}
