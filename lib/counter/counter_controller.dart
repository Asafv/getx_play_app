import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CounterController extends GetxController {
  RxInt count = 0.obs;
  RxString text =
      'This text is using GoogleFonts and will be changed when we go back from Full Screen'
          .obs;

  increment() {
    count.value++;
    update();
  }

  decrement() {
    count.value--;
    update();
  }

  changeText(String text) => this.text.value = text;

  @override
  void onInit() {
    // works when ever count is changed.
    ever(count, (_) {
      print("ever: $_");
      if (_ % 10 == 0) {
        Get.snackbar(
            "ever Worker - REACHED $_", "show me from anywhere is code");
      }
    });

    debounce(count, (_) => debugPrint("debounce: $_"),
        time: Duration(milliseconds: 500));
    super.onInit();
  }
}
