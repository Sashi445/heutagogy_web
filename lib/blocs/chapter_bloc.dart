import 'dart:async';

import 'package:heutagogy_web/models/chapter_class.dart';

class ChaptersBloc{
  List<Chapter> _chapters = [];

  StreamController<List<Chapter>> _controller = StreamController<List<Chapter>>();

  Stream<List<Chapter>> get chapterStream => _controller.stream;

  void onData({Chapter chapter}){
    _chapters.add(chapter);
    _controller.sink.add(_chapters);
  }

  void close(){
    _controller.close();
  }

}