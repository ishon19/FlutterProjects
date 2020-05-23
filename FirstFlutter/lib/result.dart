import 'package:flutter/material.dart';

class Results extends StatelessWidget {
  final Function reset;
  final int score;

  String get displayText {
    String toReturn = 'Quiz Over';
    if (score <= 15) {
      toReturn = 'You Can Do this! Total Score $score';
    } else if (score > 15 && score < 30) {
      toReturn = 'Pretty Cool! Total Score $score';
    } else if (score == 30) {
      toReturn = 'Mind Blowing! Total Score $score';
    }
    return toReturn;
  }

  Results({@required this.reset, this.score});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Text(
          displayText,
          style: TextStyle(
              fontSize: 25, color: Colors.green, fontWeight: FontWeight.bold),
        ),
        RaisedButton(
          onPressed: reset,
          color: Colors.lightBlue,
          child: Text(
            'Click to restart Quiz',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    ));
  }
}
