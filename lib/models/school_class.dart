import 'package:heutagogy_web/models/class_class.dart';

class School{
  String schoolName;
  String schoolType;
  List<Class> classes;
  School({this.classes, this.schoolName, this.schoolType});

  factory School.fromJson(Map<String, dynamic> jsonData){
    List _classesData = jsonData['classes'];
    List<Class> _classes  = _classesData.map((e) => Class.fromJson(e)).toList();
    return School(
      schoolName: jsonData['schoolName'],
      classes: _classes
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'schoolName' : schoolName,
      'classes' : classes.map((e) => e.toMap()).toList()
    };
  }

}