import 'package:get/get.dart';

class MainController extends GetxController {
  RxBool isDarkMode = false.obs;
  RxBool isValidEmail = false.obs;

  changeTheme(bool isDark) => isDarkMode.value = isDark;
  validateEmail(String s) => isValidEmail.value = GetUtils.isEmail(s);
}
