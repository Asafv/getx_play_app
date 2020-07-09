import 'dart:async';

import 'package:get/get.dart';

enum FetchState { LOADING, ERROR, COMPLETE }

class FetchApiController extends GetxController {
//  static FetchApiController get to => Get.find();
  StreamController<FetchState> fetchState = StreamController<FetchState>();

  RxString apiData = 'fetching...'.obs;

  @override
  void onInit() {
    _fetchApi();
    super.onInit();
  }

  @override
  void onClose() {
    fetchState.close();
    super.onClose();
  }

  void _fetchApi() {
    fetchState.add(FetchState.LOADING);
    Future.delayed(Duration(seconds: 3)).whenComplete(() {
      apiData.value = "Data has been fetch from server.";
      fetchState.add(FetchState.COMPLETE);
    }).catchError((onError) => fetchState.add(FetchState.ERROR));
  }
}
