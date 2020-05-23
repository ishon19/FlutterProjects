import 'package:flutter/material.dart';
import 'package:FirstFlutter/question.dart';
import 'package:FirstFlutter/answer.dart';

class Quiz extends StatelessWidget {

  final List<Map<String,Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Quiz({@required this.questions, @required this.questionIndex, @required this.answerQuestion});

  @override
  Widget build(BuildContext context) {
    return Column(
          children: <Widget>[
            Question(questions[questionIndex]['question']),
            ...((questions[questionIndex]['answers']) as List<Map<String,Object>>)
                .map((data) {
              return Answer(()=>answerQuestion(data['score']), data['text']);
            }).toList()
          ],
        );
  }
}