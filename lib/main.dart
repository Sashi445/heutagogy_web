import 'package:flutter/material.dart';
import 'package:heutagogy_web/blocs/add_questions_bloc.dart';
import 'package:heutagogy_web/blocs/chapter_bloc.dart';
import 'package:heutagogy_web/blocs/tests_bloc.dart';
import 'package:heutagogy_web/models/chapter_class.dart';
import 'package:heutagogy_web/models/school_class.dart';
import 'package:heutagogy_web/services/firebase_auth.dart';
import 'package:heutagogy_web/services/firebase_cloud_firestore.dart';
import 'package:heutagogy_web/services/load_data_from_json.dart';
import 'package:heutagogy_web/views/landing_page.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MyApp());
}

//class Root extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MultiProvider(
//      providers: [
//        Provider<AddQuestionsBloc>(create: (_) => AddQuestionsBloc(),),
//        Provider<TestsBloc>(create: (_) => TestsBloc(),),
//        Provider<ChaptersBloc>(create: (_) => ChaptersBloc(),)
//      ],
//      child: MyApp(),
//    );
//  }
//}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Auth>(create: (context) => Auth(),),
        Provider<AddQuestionsBloc>(create: (_) => AddQuestionsBloc(),),
        Provider<TestsBloc>(create: (_) => TestsBloc(),),
        Provider<ChaptersBloc>(create: (_) => ChaptersBloc(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Root(),
      ),
    );
  }
}

