import 'package:clean_architecture_getx/data/datasource/base_service.dart';
import 'package:clean_architecture_getx/domain/entities/login_body.dart';
import 'package:clean_architecture_getx/domain/entities/user_response.dart';
import 'package:get/get.dart';

import '../../domain/entities/login_response.dart';

class ApiDataSource extends BaseService{


  Future<LoginResponse> login(LoginBody loginBody) async {
    Response<dynamic> response;
    try{
      response = await post("api/login", loginBody);

      return LoginResponse.fromJson(response.body);
    } catch(e){

    }
  }

}