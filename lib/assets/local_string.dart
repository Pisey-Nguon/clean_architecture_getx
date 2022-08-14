import 'package:clean_architecture_getx/assets/app_local.dart';
import 'package:get/get.dart';
class LocaleString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      AppLocal.employee: 'Employee',
    },
    'km_KH': {
      AppLocal.employee: 'បុគ្គលិក',
    }
  };
}
