import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heutagogy_web/blocs/chapter_bloc.dart';
import 'package:heutagogy_web/models/chapter_class.dart';
import 'package:heutagogy_web/views/tests_viewer.dart';

class ChapterViewer extends StatelessWidget {
  String _chapter;

  ChaptersBloc chaptersBloc = ChaptersBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.grey[200],
      body: StreamBuilder(
        stream: chaptersBloc.chapterStream,
        initialData: <Chapter>[],
        builder: (context, snapshot){
          if(snapshot.hasData){
            List<Chapter> _chapters = snapshot.data;
            return Container(
              padding: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: _chapters.length + 1,
                itemBuilder: (context, index){
                  return index == 0 ? RaisedButton(
                    child: Text('+'+ ' ' + 'Add Chapter', style: GoogleFonts.varelaRound(fontSize: 17, color: Colors.blue),),
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Add Chapter'),
                            content: SizedBox(
                              height: 200,
                              width: 700,
                              child: TextField(
                                autofocus: true,
                                onChanged: (String value){
                                  _chapter = value;
                                },
                                decoration: InputDecoration(
                                    labelText: 'Enter the chapter name'
                                ),
                              ),
                            ),
                            actions: [
                              FlatButton(
                                child: Text('Cancel'),
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Text('Add'),
                                onPressed: (){
                                  chaptersBloc.onData(chapter : Chapter(chapterName: _chapter, tests: []));
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          )
                      );
                    },
                  ): Container(
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 7),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                          )
                        ]
                    ),
                    child: ListTile(
                      onTap: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => TestViewer()
                            )
                        );
                      },
                      title: Text('${_chapters.elementAt(index - 1).chapterName}', style: GoogleFonts.varelaRound(fontSize: 30),),
                    ),
                  );
                },
              ),
            );
          }else if(snapshot.hasError){
            return Center(child: Text('${snapshot.error}'),);
          }return Center(child: CircularProgressIndicator(),);
        },
      )
    );
  }
}
