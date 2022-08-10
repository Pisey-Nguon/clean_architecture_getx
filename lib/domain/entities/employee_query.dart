class EmployeeQuery {
  final String page;
  final int perPage;

  EmployeeQuery({required this.page,required this.perPage});

  factory EmployeeQuery.fromJson(Map<String, dynamic> json) {
    return EmployeeQuery(page: json["page"], perPage: json["per_page"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "page": page,
      "per_page": perPage
    };
  }
}
