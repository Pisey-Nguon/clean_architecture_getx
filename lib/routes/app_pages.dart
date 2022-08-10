import 'package:clean_architecture_getx/presentation/feature/employee/binding/employee_binding.dart';
import 'package:clean_architecture_getx/presentation/feature/employee/view/employee_page.dart';
import 'package:clean_architecture_getx/presentation/feature/home/binding/home_binding.dart';
import 'package:clean_architecture_getx/presentation/feature/home/view/home_page.dart';
import 'package:clean_architecture_getx/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();
  static const initial = AppRoutes.home;
  static final routes = [
    GetPage(
        name: AppRoutes.home,
        page: () => const HomePage(),
        binding: HomeBinding()),
    GetPage(
        name: AppRoutes.employee,
        page: () => const EmployeePage(),
        binding: EmployeeBinding())
  ];
}
