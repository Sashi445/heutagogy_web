

import 'dart:async';

import 'package:heutagogy_web/models/school_class.dart';

class SchoolControllerBloc{

  StreamController<School> _controller = StreamController<School>();

  Stream<School> get schoolControllerStream => _controller.stream;

}