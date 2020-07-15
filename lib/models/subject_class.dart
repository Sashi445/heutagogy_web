import 'package:heutagogy_web/models/chapter_class.dart';

class Subject{
  final String subjectName;
  final List<Chapter> chapters;
  Subject({this.subjectName, this.chapters});

  factory Subject.fromJson(Map<String, dynamic> jsonData){
    List _chaptersData = jsonData['chapters'];
    List<Chapter> _chapters = _chaptersData.map((e) => Chapter.fromJson(e)).toList();
    return Subject(
      subjectName: jsonData['subjectName'],
      chapters: _chapters
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'subjectName' : subjectName,
      'chapters' : chapters.map((e) => e.toMap()).toList()
    };
  }

}