import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart' show  rootBundle;
import 'package:heutagogy_web/models/school_class.dart';

class SchoolsFromJson{

  Future _loadJsonString() async{
    return await rootBundle.loadString('assets/rootdata.json');
  }

  Future loadSchools() async{
    String jsonResponse = await _loadJsonString();
    final jsonData = json.decode(jsonResponse);
    List _schoolsJson = jsonData;
    List<School> schools = _schoolsJson.map((e) => School.fromJson(e)).toList();
    return schools;
  }

}