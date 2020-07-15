import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:heutagogy_web/models/chapter_class.dart';
import 'package:heutagogy_web/models/class_class.dart';
import 'package:heutagogy_web/models/school_class.dart';
import 'package:heutagogy_web/models/section_class.dart';
import 'package:heutagogy_web/models/subject_class.dart';
import 'package:heutagogy_web/models/test_class.dart';

class Database{

  final Firestore instance =  Firestore.instance;
  
  Future setSchoolData({School school}) async{
    try{
      final CollectionReference rootReference = instance.collection('root');
      final CollectionReference schoolsReference = rootReference.document('${school.schoolType}').collection('schools');
      final DocumentReference schoolReference = schoolsReference.document('${school.schoolName}');
      await schoolReference.setData({'schoolName' : school.schoolName});
      final CollectionReference classesReference = schoolReference.collection('classes');
      for(int i=0; i<school.classes.length; i++){

        await classesReference.document('${school.classes.elementAt(i).className}').setData({'class' : school.classes.elementAt(i).className});

        final CollectionReference sectionsReference = classesReference.document('${school.classes.elementAt(i).className}').collection('sections');

        Class standard = school.classes.elementAt(i);

        for(int j=0; j< standard.sections.length; j++) {

          Section section = standard.sections.elementAt(j);

          await sectionsReference.document('${section.section}').setData({'section' : section.section});

          final CollectionReference subjectsReference = sectionsReference.document('${section.section}').collection('subjects');

          for(int k =0 ; k<section.subjects.length; k++) {

            Subject subject = section.subjects.elementAt(k);

            await subjectsReference.document('${subject.subjectName}').setData({'subjectName' : subject.subjectName });

            final CollectionReference chaptersReference = subjectsReference.document('${subject.subjectName}').collection('chapters');

            for(int l=0; l< subject.chapters.length; l++) {

              Chapter chapter = subject.chapters.elementAt(l);

              await chaptersReference.document('${chapter.chapterName}').setData({'chapterName' : chapter.chapterName});

              final CollectionReference testsReference = chaptersReference.document('${chapter.chapterName}').collection('tests');

              for(int m = 0; m < chapter.tests.length; m++){

                Test test  = chapter.tests.elementAt(m);

                await testsReference.document('${test.title}').setData(test.toMap());

              }
            }
          }
        }
      }
    }catch(e){
      throw Exception('FAILED TO UPLOAD SCHOOL DATA DUE TO : $e');
    }
  }

  Future addSchool({School school}) async{
    try{
      final CollectionReference reference = instance.collection('root').document('${school.schoolType}').collection('schools');

    }catch(e){

    }
  }

  Future addSection({Section section}) async{

  }

  Future addTest({Test test, Class standard, School school}) async{

  }

  Future getSchoolsData() async{
    final CollectionReference reference = instance.collection('root');
    final CollectionReference schoolsReference = reference.document('schools').collection('');
  }

}