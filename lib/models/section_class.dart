import 'package:heutagogy_web/models/subject_class.dart';

class Section{
  final String section;
  final List<Subject> subjects;
  Section({this.section,this.subjects});

  factory Section.fromJson(Map<String, dynamic> jsonData){
    List _subjectsData = jsonData['subjects'];
    List<Subject> _subjects = _subjectsData.map((e) => Subject.fromJson(e)).toList();
    return Section(
      section: jsonData['section'],
      subjects: _subjects
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'section' : section,
      'subjects' : subjects.map((e) => e.toMap()).toList()
    };
  }

}