

import 'dart:async';

import 'package:heutagogy_web/models/class_class.dart';

class StandardController{
  List<Class> _classes = [];

  StreamController<List<Class>> _controller = StreamController<List<Class>>();

  Stream<List<Class>> get classesStream => _controller.stream;

  void onData({Class standard}){

  }


  void close(){
    _controller.close();
  }

}