class RefreshTokenResponse{
  final String newToken;

  RefreshTokenResponse({required this.newToken});

  factory RefreshTokenResponse.fromJson(Map<String,dynamic> json){
    return RefreshTokenResponse(newToken: json['newToken']);
  }
}