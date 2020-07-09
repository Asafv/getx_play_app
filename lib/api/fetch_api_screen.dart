import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'api_controller.dart';

class FetchApiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FetchApiController>(
        init: FetchApiController(),
        builder: (_) {
          return Scaffold(
              appBar: AppBar(
                title: Text("Fetch API"),
                leading: InkWell(
                  onTap: () =>
                      Get.back(result: "I have returned with this message"),
                  child: Icon(Icons.keyboard_backspace),
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  StreamBuilder(
                    stream: _.fetchState.stream,
                    builder: (context, AsyncSnapshot<FetchState> snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data) {
                          case FetchState.LOADING:
                            return Container(
                              child: Center(child: CircularProgressIndicator()),
                            );
                          case FetchState.COMPLETE:
                            return Container(
                              child: Text(
                                "Fetch Complete",
                                style: TextStyle(color: Colors.green),
                              ),
                            );
                          case FetchState.ERROR:
                            return Container(
                              child: Text(
                                "ERROR",
                                style: TextStyle(color: Colors.red),
                              ),
                            );
                        }
                      }
                      return Container();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Obx(
                      () => Text(
                        "${_.apiData.value}",
                        style: TextStyle(fontSize: 60),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ));
        });
  }
}
