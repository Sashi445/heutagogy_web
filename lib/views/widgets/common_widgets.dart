import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heutagogy_web/models/question_class.dart';
import 'package:heutagogy_web/models/test_class.dart';

class QuestionViewer extends StatelessWidget {
  Question question;
  QuestionViewer({this.question});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width/2,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey
            )
          ]
      ),
      child: Column(
        children: [
          Text('${question.question}'),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: question.options.map((e) => Container(
              margin: EdgeInsets.all(3),
              decoration:BoxDecoration(
                  color: e.value ? Colors.green : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey
                    )
                  ]
              ),
              child: ListTile(
                title: Text('${e.text}'),
              ),
            )).toList(),
          )
        ],
      ),
    );
  }
}

class TestVisualize extends StatelessWidget{
  final Test test;
  TestVisualize({this.test});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height:MediaQuery.of(context).size.height/6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${test.title}'),
                  Text('${test.introText}'),
                  Text('${test.level}')
                ],
              ),
            ),
          ),
          Column(
            children: test.questions.map((e) => QuestionViewer(question: e,)).toList(),
          )
        ],
      ),
    );
  }
}