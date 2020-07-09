import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_libs/counter/counter_controller.dart';

class CounterView extends StatelessWidget {
// Instantiate your class using Get.put() to make it available for all "child" routes there.
  final CounterController c = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => Text(
                '${c.text.value}',
                textAlign: TextAlign.center,
                style: GoogleFonts.zcoolKuaiLe(fontSize: 26),
              ),
            ),
          ),
          Text(
            'This is a "BLoC" like sample'
            '\nController will use workers as well to observe changes on count',
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FlatButton.icon(
                  onPressed: c.decrement,
                  label: Text(''),
                  icon: Icon(Icons.remove),
                ),
                Obx(
                  () => Text(
                    '${c.count.string}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                FlatButton.icon(
                  onPressed: c.increment,
                  icon: Icon(Icons.add),
                  label: Text(""),
                )
              ],
            ),
          ),
          RaisedButton(
            child: Text("show counter_view in full screen"),
            onPressed: openFullScreen,
          ),
        ],
      ),
    );
  }

  void openFullScreen() async {
    var data = await Get.to(FullScreenCount());
    if (data != null) {
      c.changeText(data);
    }
  }
}

class FullScreenCount extends StatelessWidget {
  // You can ask Get to find a Controller that is being used by another page and redirect you to it.
  final CounterController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("full screen"),
          leading: InkWell(
            onTap: () => Get.back(result: "I have returned with this message"),
            child: Icon(Icons.keyboard_backspace),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "I will return data back to previous screen :)",
              style: TextStyle(fontSize: 26),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FlatButton.icon(
                  onPressed: c.decrement,
                  label: Text(''),
                  icon: Icon(Icons.remove),
                ),
                FlatButton.icon(
                  onPressed: c.increment,
                  icon: Icon(Icons.add),
                  label: Text(""),
                )
              ],
            ),

            /// option 1
            Column(
              children: <Widget>[
                Text(
                  "This will not change unless we wrap it with Obx().",
                  style: GoogleFonts.catamaran(fontSize: 18, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'with Get.find():\n${c.count.string}',
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),

                /// option 2
                Text(
                  "This will change because we are calling update on controller.",
                  style: GoogleFonts.catamaran(
                      fontSize: 18, color: Colors.lightGreen),
                  textAlign: TextAlign.center,
                ),
                GetBuilder<CounterController>(
                  builder: (_) => Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'with GatBuilder:\n${_.count.value}',
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
