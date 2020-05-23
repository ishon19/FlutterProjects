import 'package:flutter/material.dart';

class Answer extends StatelessWidget {

  final Function callBack;
  final String answerText;

  Answer(this.callBack, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 50, right: 50),
        child: RaisedButton(
          color: Colors.blue,
          textColor: Colors.white,
          child: Text(answerText),
          onPressed: callBack,
        ));
  }
}
