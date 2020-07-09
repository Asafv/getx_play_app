import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_flutter_libs/counter/counter_view.dart';

import 'api/fetch_api_screen.dart';
import 'home_binding.dart';
import 'main_controller.dart';
import 'stack/pop_stack_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
//  // This widget is the root of your application.
//  final MainController c = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routingCallback: (routing) {
        debugPrint("routingCallback: ${routing.current}");
        if (routing.current == '/Screen2') {
          debugPrint("Screen2 route... we can do something");
//          _showAds();
        }
      },
      home: MyHomePage(),
      initialBinding: MyHomeBinding(),
    );
  }

  // XXX this is not working for some reason.
  void _showAds() async {
    Get.defaultDialog(title: "This is an Ad");
  }
}

// finding the controller from dependency injection using the binding api
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("HomePage"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _themeRadioButton(),
                  _apiView(),
                ],
              ),
              _emailValidator(),
              CounterView(),
              _stackView(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _bottomSheet(),
                  _defaultDialog(),
                  _bottomSheetContainer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _stackView() {
    var args = Get.arguments;
    var stackText = 'NEED TO STACK UP';
    var textColor = Colors.red;
    if (args != null) {
      stackText = args.toString();
      textColor = Colors.green;
    }

    return Column(
      children: <Widget>[
        Text(
          "$stackText",
          style: TextStyle(color: textColor),
        ),
        RaisedButton(
          onPressed: () =>
              Get.to(PopStackPages(), transition: Transition.downToUp),
          child: Text("Stack Pages Test"),
        ),
      ],
    );
  }

  Widget _bottomSheet() {
    return RaisedButton(
      onPressed: () => Get.snackbar("Hello!", "I am snacky"),
      child: Text("Snackbar"),
    );
  }

  Widget _defaultDialog() {
    return RaisedButton(
      onPressed: () => Get.defaultDialog(
        title: "Default Dialog",
        middleText: "sheker kolsheo",
        actions: [
          FlatButton(onPressed: () => Get.back(), child: Text("close")),
          FlatButton(
              onPressed: _showBottomSheet, child: Text("show bottomsheet"))
        ],
      ),
      child: Text("Dialog"),
    );
  }

  Widget _bottomSheetContainer() {
    return RaisedButton(
      onPressed: _showBottomSheet,
      child: Text("BottomSheet"),
    );
  }

  _apiView() {
    return Column(
      children: <Widget>[
        Text("Fetch API"),
        RaisedButton(
          onPressed: () => Get.to(FetchApiScreen()),
          child: Text("Fetch API"),
        )
      ],
    );
  }

  _themeRadioButton() {
    return GetX<MainController>(
      builder: (_) => Column(
        children: <Widget>[
          Text("Change Theme"),
          Container(
            height: 50,
            child: Switch(
              value: _.isDarkMode.value,
              onChanged: (isOn) {
                _.changeTheme(isOn);
                Get.changeTheme(
                  Get.isDarkMode ? ThemeData.light() : ThemeData.dark(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet() {
    Get.bottomSheet(
      Container(
        child: Wrap(
          children: <Widget>[
            ListTile(
                leading: Icon(Icons.music_note),
                title: Text('Music'),
                onTap: () => Get.back()),
            ListTile(
              leading: Icon(Icons.videocam),
              title: Text('Video'),
              onTap: () => Get.back(),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.green,
      isDismissible: true,
    );
  }

  _emailValidator() {
    return GetX<MainController>(
      builder: (_) => Container(
        height: 50,
        width: Get.width * 0.8,
        child: TextFormField(
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: _.isValidEmail.value ? Colors.greenAccent : Colors.red,
                  width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
            ),
            hintText: 'Email validator: user@email.com',
          ),
          onChanged: _.validateEmail,
          onFieldSubmitted: (s) {
            if (s.isNotEmpty && !_.isValidEmail.value) {
              Get.defaultDialog(
                title: "Invalid Email",
                middleText: "Please follow standard email convention.",
              );
            }
          },
        ),
      ),
    );
  }
}
