import 'package:clean_architecture_getx/data/repository/login_repository_impl.dart';
import 'package:clean_architecture_getx/domain/repository/login_repository.dart';
import 'package:clean_architecture_getx/domain/usecase/login_usecase.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginRepository>(LoginRepositoryImpl(apiDataSource: Get.find()));
    Get.put<LoginUseCase>(LoginUseCase(loginRepository: Get.find()));
  }
}
