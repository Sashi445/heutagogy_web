import 'package:heutagogy_web/models/test_class.dart';

class Chapter{
  final String chapterName;
  final List<Test> tests;
  Chapter({this.tests, this.chapterName});

  factory Chapter.fromJson(Map<String, dynamic> jsonData){
    List _testData = jsonData['tests'];
    List<Test> _tests = _testData.map((e) => Test.fromJson(e)).toList();
    return Chapter(
      chapterName: jsonData['chapterName'],
      tests: _tests
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'chapterName' : chapterName,
      'tests' : tests.map((e) => e.toMap()).toList()
    };
  }

}