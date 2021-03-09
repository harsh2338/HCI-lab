import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController name = TextEditingController();
  TextEditingController diameter = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController lat = TextEditingController();
  TextEditingController long = TextEditingController();

  String type;
  TextEditingController _controller1, _controller2;
  String _valueChanged1 = '';
  String _valueChanged2 = '';
  String _valueSaved1 = '';
  String _valueSaved2 = '';
  String _valueToValidate1 = '';
  String _valueToValidate2 = '';
  @override
  void initState() {
    _controller1 = TextEditingController(text: DateTime.now().toString());
    String lsHour = TimeOfDay.now().hour.toString().padLeft(2, '0');
    String lsMinute = TimeOfDay.now().minute.toString().padLeft(2, '0');
    _controller2 = TextEditingController(text: '$lsHour:$lsMinute');
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    diameter.dispose();
    height.dispose();
    super.dispose();
    _controller1.dispose();
    _controller2.dispose();
    lat.dispose();
    long.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Tree Name',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(
                        5,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: name,
                      enableInteractiveSelection: false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 10.0),
                          border: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: 'Enter Tree Name'),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Tree Type',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(
                        5,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: Container(),
                      value: type,
                      hint: Text('Select Tree Type'),
                      icon: Icon(Icons.arrow_drop_down),
                      items: <String>[
                        'Deciduos',
                        'Coniferous',
                        'Evergreen',
                      ].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          type = val;
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    child: DateTimePicker(
                      type: DateTimePickerType.date,
                      dateMask: 'yyyy/MM/dd',
                      controller: _controller1,
                      //initialValue: _initialValue,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      icon: Icon(Icons.event),
                      dateLabelText: 'Date',
                      //locale: Locale('en', 'US'),
                      onChanged: (val) => setState(() => _valueChanged1 = val),
                      validator: (val) {
                        setState(() => _valueToValidate1 = val);
                        return null;
                      },
                      onSaved: (val) => setState(() => _valueSaved1 = val),
                    ),
                  ),
                  Expanded(
                    child: DateTimePicker(
                      type: DateTimePickerType.time,
                      controller: _controller2,
                      //initialValue: _initialValue,
                      icon: Icon(Icons.access_time),
                      timeLabelText: "Time",
                      //use24HourFormat: false,
                      //locale: Locale('en', 'US'),
                      onChanged: (val) => setState(() => _valueChanged2 = val),
                      validator: (val) {
                        setState(() => _valueToValidate2 = val);
                        return null;
                      },
                      onSaved: (val) => setState(() => _valueSaved2 = val),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'GPS Location',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    )),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Latitude :      ',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      child: Container(
                        height: 38,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(
                              5,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            // keyboardType: TextInputType.number,
                            controller: lat,
                            enableInteractiveSelection: false,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 10.0),
                                border: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'Enter Latitude'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'Longitude :   ',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      child: Container(
                        height: 38,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(
                              5,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            // keyboardType: TextInputType.number,
                            controller: long,
                            enableInteractiveSelection: false,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 10.0),
                                border: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'Enter Longitude'),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Dimensions',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    )),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 60,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                '   Height (m)',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 38,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: height,
                                    enableInteractiveSelection: false,
                                    decoration: InputDecoration(
                                        hintText: 'Enter Height'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: 5,
                    // ),
                    Expanded(
                      child: Container(
                        height: 60,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                '   Diameter (m)',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 38,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: diameter,
                                    enableInteractiveSelection: false,
                                    decoration: InputDecoration(
                                        hintText: 'Enter Diameter'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: RaisedButton(
                    color: Color.fromRGBO(0, 100, 0, 1),
                    onPressed: () {},
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
              ),
            ),
          )
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
