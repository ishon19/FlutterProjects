import 'package:flutter/material.dart';

class App extends StatelessWidget {
  List<String> questions;
  int index;
  Function callback;

  App(
      {@required this.questions,
      @required this.index,
      @required this.callback});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Text(questions[index]),
        RaisedButton(
          child: Text('Change Text'),
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: callback,
        )
      ],
    ));
  }
}
