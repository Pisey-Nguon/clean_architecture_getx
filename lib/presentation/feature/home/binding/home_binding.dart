import 'package:clean_architecture_getx/data/repository/login_repository_impl.dart';
import 'package:clean_architecture_getx/domain/repository/login_repository.dart';
import 'package:clean_architecture_getx/domain/usecase/login_usecase.dart';
import 'package:clean_architecture_getx/presentation/feature/home/controller/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<LoginRepository>(LoginRepositoryImpl(apiDataSource: Get.find()));
    Get.put<LoginUseCase>(LoginUseCaseImpl(loginRepository: Get.find()));
    Get.put<HomeController>(HomeController(loginUseCase: Get.find()));
  }
}