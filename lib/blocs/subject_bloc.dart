import 'dart:async';

import 'package:heutagogy_web/models/subject_class.dart';

class SubjectBloc{
  List<Subject> _subjects = [];

  StreamController<List<Subject>> _controller = StreamController<List<Subject>>();

  Stream<List<Subject>> get subjectController => _controller.stream;

  void onData({Subject subject}){
    _subjects.add(subject);
    _controller.sink.add(_subjects);
  }

  void close(){
    _controller.close();
  }
}