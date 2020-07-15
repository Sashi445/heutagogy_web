import 'package:heutagogy_web/models/question_class.dart';

class Test{
  final String title;
  final String introText;
  final String level;
  List<Question> questions;
  Test({this.title, this.level, this.questions, this.introText});

  factory Test.fromJson(Map<String, dynamic> jsonData){
    List _questionsData = jsonData['questions'];
    List<Question> _questions = _questionsData.map((e) => Question.fromJson(e)).toList();
    return Test(
      title: jsonData['title'],
      introText: jsonData['introText'],
      level: jsonData['level'],
      questions: _questions
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'title' : title,
      'introText' : introText,
      'level' : level,
      'questions' : questions.map((e) => e.toMap()).toList()
    };
  }

}