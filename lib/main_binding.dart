import 'package:clean_architecture_getx/data/datasource/api_datasource.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiDataSource());
  }
}
