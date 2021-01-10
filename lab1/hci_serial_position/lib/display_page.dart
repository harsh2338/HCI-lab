import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hci_serial_position/select_page.dart';
import 'package:hci_serial_position/timer.dart';

class DisplayPage extends StatefulWidget {
  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  bool go;
  @override
  void initState() {
    go = false;
    super.initState();
  }

  Future<void> test() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      go = true;
    });
  }

  List<String> animals = [
    "Lemming",
    "Leopard",
    "Eagle",
    "Scorpion",
    "Turkey",
    "Elephant",
    "Lion",
    "Cat",
    "Snake",
    "Rabbit",
  ];
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 10), () {
      // 5s over, navigate to a new page
      Navigator.push(context, MaterialPageRoute(builder: (_) => SelectPage()));
    });
    return SafeArea(
      child: Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(height: 70, child: CountDownTimer()),
                for (String s in animals)
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(s, style: TextStyle(fontSize: 30)),
                    ],
                  ),
              ],
            )),
      ),
    );
  }
}
