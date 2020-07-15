import 'package:heutagogy_web/models/section_class.dart';

class Class{
  final String className;
  final List<Section> sections;
  Class({this.className, this.sections});

  factory Class.fromJson(Map<String, dynamic> jsonData){
    List _sectionsData = jsonData['sections'];
    List<Section> _sections = _sectionsData.map((e) => Section.fromJson(e)).toList();
    return Class(
      className: jsonData['className'],
      sections: _sections
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'className' : className,
      'sections' : sections.map((e) => e.toMap()).toList()
    };
  }

}