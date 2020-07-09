import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flutter_libs/home_binding.dart';

import '../main.dart';

const double _fontSize = 26;

class PopStackPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("main"),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.keyboard_backspace),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "This page has a pop gesture on supported devices."
              "\nand enters from bottom to top",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: _fontSize),
            ),
          ),
          RaisedButton(
            onPressed: () => Get.to(
              Screen1(),
              arguments: 1,
              duration: Duration(milliseconds: 1000),
              popGesture: false,
            ),
            child: Text("another one"),
          ),
        ],
      ),
    );
  }
}

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${Get.arguments}"),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.keyboard_backspace),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "This page had a slooooww animation"
              "\nAnd its pop gesture is disabled.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: _fontSize),
            ),
          ),
          RaisedButton(
            onPressed: () => Get.to(Screen2(),
                arguments: 2,
                preventDuplicates: false,
                opaque: true,
                transition: Transition.rightToLeftWithFade),
            child: Text("Page 2"),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "You can also stack the same screen.",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: _fontSize),
            ),
          ),
          RaisedButton(
            onPressed: () => Get.to(Screen1(),
                arguments: 1,
                duration: Duration(milliseconds: 600),
                popGesture: false,
                preventDuplicates: false,
                transition: Transition.topLevel),
            child: Text("Stack Page1 again"),
          )
        ],
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${Get.arguments}"),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.keyboard_backspace),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Popping all pages back to HomePage with binding",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: _fontSize),
            ),
          ),
          RaisedButton(
            onPressed: () => Get.offAll(MyHomePage(),
                binding: MyHomeBinding(),
                arguments: "You have completed stack pages.",
                transition: Transition.downToUp),
            child: Text("Pop'em all"),
          )
        ],
      ),
    );
  }
}
