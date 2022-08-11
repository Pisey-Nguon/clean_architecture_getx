import 'package:clean_architecture_getx/presentation/feature/employee/binding/employee_binding.dart';
import 'package:clean_architecture_getx/presentation/feature/employee/view/employee_page.dart';
import 'package:clean_architecture_getx/presentation/feature/employee_details/binding/employee_details_binding.dart';
import 'package:clean_architecture_getx/presentation/feature/employee_details/view/employee_details_page.dart';
import 'package:clean_architecture_getx/presentation/feature/home/binding/home_binding.dart';
import 'package:clean_architecture_getx/presentation/feature/home/view/home_page.dart';
import 'package:clean_architecture_getx/routes/app_routes.dart';
import 'package:clean_architecture_getx/utils/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppPages {
  AppPages._();

  static String initial(){
    final box = GetStorage();
    var token = box.read(Constants.keyToken);
    if(token != null){
      return AppRoutes.employee;
    }else{
      return AppRoutes.home;
    }
  }
  static final routes = [
    GetPage(
        name: AppRoutes.home,
        page: () => const HomePage(),
        binding: HomeBinding()),
    GetPage(
        name: AppRoutes.employee,
        page: () => const EmployeePage(),
        binding: EmployeeBinding()),
    GetPage(
        name: AppRoutes.employeeDetails,
        page: () => const EmployeeDetailsPage(),
        binding: EmployeeDetailsBinding())
  ];
}
