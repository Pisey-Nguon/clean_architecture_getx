class LoginBodyWithPassword {
  String? email;
  String? password;

  LoginBodyWithPassword({this.email, this.password});

  LoginBodyWithPassword.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
