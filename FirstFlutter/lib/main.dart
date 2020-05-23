import 'package:FirstFlutter/result.dart';
import 'package:flutter/material.dart';
import 'package:FirstFlutter/quiz.dart';

void main() {
  runApp(_MyFirstApp());
}

class _MyFirstApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyFirstAppState();
  }
}

class _MyFirstAppState extends State<_MyFirstApp> {
  var _questionIndex = 0;
  var _totalScore = 0;

  void _answerQuestion(int score) {
    print("Inside the function");
    _totalScore+=score;
    print('Total score as of now is : $_totalScore');
    setState(() {
      _questionIndex++;
    });
  }

  void _reset() {
    _questionIndex = 0;
    _totalScore = 0;
    //Just to reload the page again
    setState(() {});
  }

  var _questions = [
    {
      'question': "What's your name?",
      'answers': [{'text':'Red', 'score':10}, {'text':'Black','score':5}, {'text':'Green','score':5}]
    },
    {
      'question': "How are you doing today?",
      'answers': [{'text':'Ok','score':10}, {'text':'Not Okay','score':5}]
    },
    {
      'question': 'Are you hungry?',
      'answers': [{'text':'Yes', 'score':10}, {'text':'No','score':5}]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ishon Apps'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                questions: _questions,
                questionIndex: _questionIndex,
                answerQuestion: _answerQuestion,
              )
            : Results(
                reset: _reset,
                score: _totalScore,
              ),
      ),
    );
  }
}
