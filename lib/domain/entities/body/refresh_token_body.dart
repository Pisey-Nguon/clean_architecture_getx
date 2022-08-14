class RefreshTokenBody{
  final String currentToken;

  RefreshTokenBody({required this.currentToken});

  Map<String,dynamic> toJson(){
    Map<String,dynamic> data = {};
    data["currentToken"] = currentToken;
    return data;
  }
}