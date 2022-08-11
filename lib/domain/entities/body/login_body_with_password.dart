class LoginBodyWithPassword {
  String? email;
  String? password;

  LoginBodyWithPassword({this.email, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
