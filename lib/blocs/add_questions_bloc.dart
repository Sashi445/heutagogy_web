

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:heutagogy_web/blocs/tests_bloc.dart';
import 'package:heutagogy_web/models/question_class.dart';
import 'package:heutagogy_web/models/test_class.dart';
import 'package:provider/provider.dart';

class AddQuestionsBloc{
  List<Question> _questions = [];

  StreamController<List<Question>> _controller = StreamController<List<Question>>.broadcast();

  Stream<List<Question>> get questionsStream => _controller.stream;

  void onData({Question question}){
    _questions.add(question);
    _controller.sink.add(_questions);
  }

  void clearQuestions(){
    _questions.clear();
  }

  void addQuestionToTest({BuildContext context, Test test}){
    test.questions = _questions;
    TestsBloc testsBloc = Provider.of<TestsBloc>(context, listen: false);
    testsBloc.onData(test:test);
  }

  void close(){
    _controller.close();
  }

}