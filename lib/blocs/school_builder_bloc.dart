

import 'dart:async';

import 'package:heutagogy_web/services/firebase_cloud_firestore.dart';

class SchoolBuilderBloc{
  final Database database = Database();

  StreamController _controller = StreamController();

  Stream get schoolsStream => _controller.stream;


}