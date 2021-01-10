import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final List<String> selected;

  const ResultsPage({Key key, @required this.selected}) : super(key: key);

  static const List<String> animals = [
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
    List<String> wrong = [];
    bool check = false;
    for (String s in selected) {
      if (!animals.contains(s)) wrong.add(s);
    }

    print(selected);
    print(wrong);

    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Results',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800),
              ),
              Text('Your score is : ${10 - wrong.length}',
                  style: TextStyle(fontSize: 20)),
              wrong.length == 0
                  ? Text('You got all correct !!!')
                  : Column(
                      children: [
                        Text('You got these animals wrong'),
                        SizedBox(
                          height: 20,
                        ),
                        for (String s in wrong) Text(s)
                      ],
                    )
            ],
          ),
        ),
      ),
    ));
  }
}
