class EmployeeQueryDelay {
  final int page;
  final int perPage;
  final int delay;

  EmployeeQueryDelay({required this.page,required this.perPage,required this.delay});

  factory EmployeeQueryDelay.fromJson(Map<String,dynamic> json){
    return EmployeeQueryDelay(page:json["page"],perPage:json["per_page"],delay: json["delay"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "page": page.toString(),
      "per_page": perPage.toString(),
      "delay": delay.toString()
    };
  }
}