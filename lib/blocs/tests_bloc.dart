import 'dart:async';

import 'package:heutagogy_web/models/test_class.dart';


class TestsBloc{
  List<Test> _tests = [];
  StreamController<List<Test>> _controller = StreamController<List<Test>>.broadcast();

  Stream<List<Test>> get testsStream => _controller.stream;

  void initialData(){
    _controller.sink.add(_tests);
  }

  void printStreamData(){
    for(int i=0; i<_tests.length; i++){
      print('${_tests.elementAt(i).title}');
      print(_tests.elementAt(i).questions.length);
      for(int j=0; j<_tests.elementAt(i).questions.length; j++ ){
        if(_tests.elementAt(i).questions.isEmpty){
          print('Nothing is present here!!');
        }
        print('Inside printing questions' + '${_tests.elementAt(i).questions.elementAt(j).question}');
      }
    }
  }

  void onData({Test test}){
    _tests.add(test);
    _controller.sink.add(_tests);
  }

  void close(){
    _controller.close();
  }
 }