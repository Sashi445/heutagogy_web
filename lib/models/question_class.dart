import 'package:heutagogy_web/models/option_class.dart';

class Question{
  final String question;
  List<Option> options;
  Question({this.options, this.question});

  factory Question.fromJson(Map<String, dynamic> jsonData){
    List _optionData = jsonData['options'];
    List<Option> _options = _optionData.map((e) => Option.fromJson(e)).toList();
    return Question(
      question: jsonData['question'],
      options: _options
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'question' : question,
      'options' : options.map((e) => e.toMap()).toList()
    };
  }

}