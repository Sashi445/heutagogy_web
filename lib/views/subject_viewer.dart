import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heutagogy_web/blocs/subject_bloc.dart';
import 'package:heutagogy_web/models/subject_class.dart';
import 'package:heutagogy_web/views/chapter_viewer.dart';

class SubjectViewer extends StatelessWidget {
  SubjectBloc subjectBloc = SubjectBloc();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
        initialData: <Subject>[],
        stream: subjectBloc.subjectController,
        builder: (context, snapshot){
          if(snapshot.hasData){
            List<Subject> _subjects = snapshot.data;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index){
                return index == 0 ? addSubjectDialog(context)
                    : InkWell(
                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => ChapterViewer()
                        )
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.all(18),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('${_subjects.elementAt(index-1).subjectName}', style: GoogleFonts.varelaRound(fontSize: 30),),
                    ),
                  ),
                );
              },
              itemCount: _subjects.length + 1,
            );
          }else if(snapshot.hasError){
            return Center(child: Text('${snapshot.error}'),);
          }return Center(child: LinearProgressIndicator(),);
        },
      )
    );
  }

  Widget addSubjectDialog(BuildContext context){
    String subjectName;
    return InkWell(
      onTap: (){
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Add Subject'),
              content: SizedBox(
                  width: 700,
                  height: 200,
                  child: TextField(
                    onChanged: (String value){
                      subjectName = value;
                    },
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Subject Name',
                    ),
                  )
              ),
              actions: [
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Submit'),
                  onPressed: (){
                    subjectBloc.onData(subject:Subject(subjectName: subjectName, chapters: []));
                    Navigator.of(context).pop();
                  },
                )
              ],
            )
        );
      },
      child: Card(
        margin: EdgeInsets.all(18),
        child: Align(
          alignment: Alignment.center,
          child: Text('+' + ' ' + 'Add Subject', style: GoogleFonts.varelaRound(fontSize: 30, color: Colors.blue),),
        ),
      ),
    );
  }
}
