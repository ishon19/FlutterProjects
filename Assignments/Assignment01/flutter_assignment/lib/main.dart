// 1) Create a new Flutter App (in this project) and output an AppBar and some text
// below it
// 2) Add a button which changes the text (to any other text of your choice)
// 3) Split the app into three widgets: App, TextControl & Text

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_course/app.dart';

void main() {
  runApp(_TestApp());
}

class _TestApp extends StatefulWidget {
  @override
  _TestAppState createState() => _TestAppState();
}

class _TestAppState extends State<_TestApp> {
  List<String> sampleTextList = [
    'Hello World',
    'Are you feeling hungry?',
    'Want some Tea?',
    'How was your day',
    'What is your plan for the day'
  ];

  int _textIndex = 0;

  void changeTexts() {
    Random random = new Random();
    int _randomNum = random.nextInt(sampleTextList.length);
    print('Random Number is: $_randomNum');
    setState(() {
      _textIndex = _randomNum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text('Assignment 01')),
          body: App(
            questions: sampleTextList,
            index: _textIndex,
            callback: changeTexts,
          )),
    );
  }
}
