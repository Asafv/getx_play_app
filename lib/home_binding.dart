import 'package:get/get.dart';
import 'package:my_flutter_libs/main_controller.dart';

class MyHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
  }
}
