import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hci_serial_position/display_page.dart';
import 'package:hci_serial_position/results_page.dart';

class SelectPage extends StatefulWidget {
  SelectPage({Key key}) : super(key: key);

  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  List<String> isSelected = [];
  List<String> random = [
    "Honey Bee",
    "Horse",
    "Iguana",
    "Jaguar",
    "Kangaroo",
    "Kiwi",
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
    "Penguin",
    "Bear",
    "Squirrel",
    "Cow",
    "Peacock",
    "Cheetah",
    "Hippo",
    "Zebra",
  ];
  getIsSelected(String ind) {
    for (int i = 0; i < isSelected.length; i++) {
      if (ind == isSelected[i]) return true;
    }
    return false;
  }

  List shuffle(List items) {
    var random = new Random();

    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {
      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

  @override
  void initState() {
    shuffle(random);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Serial Positioning'),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Text(
                  'Choose the animals u can recall',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${isSelected.length} / 10',
                  style: TextStyle(fontSize: 20),
                ),
                Wrap(
                  children: [
                    for (String s in random)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: chipBuilder(
                            text: s,
                            value: getIsSelected(s),
                            onTap: () {
                              if (getIsSelected(s))
                                isSelected.remove(s);
                              else
                                isSelected.add(s);
                              setState(() {
                                if (isSelected.length == 10) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ResultsPage(
                                                selected: isSelected,
                                              )));
                                }
                              });
                            }),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget chipBuilder(
      {@required String text, bool value = false, Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: ,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: value ? Colors.blue : Colors.black),
            color: value ? Colors.blue : null),
        child: Text(text,
            style: TextStyle(
              color: value ? Colors.white : Colors.black,
            )),
      ),
    );
  }
}
