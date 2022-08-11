class EmployeeDelayQuery {
  final int page;
  final int perPage;
  final int delay;

  EmployeeDelayQuery({required this.page,required this.perPage,required this.delay});

  factory EmployeeDelayQuery.fromJson(Map<String,dynamic> json){
    return EmployeeDelayQuery(page:json["page"],perPage:json["per_page"],delay: json["delay"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "page": page.toString(),
      "per_page": perPage.toString(),
      "delay": delay.toString()
    };
  }
}