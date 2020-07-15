import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heutagogy_web/blocs/tests_bloc.dart';
import 'package:heutagogy_web/models/test_class.dart';
import 'package:heutagogy_web/views/forms/add_test_form.dart';
import 'package:heutagogy_web/views/widgets/common_widgets.dart';
import 'package:provider/provider.dart';

class TestViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TestsBloc testsBloc = Provider.of<TestsBloc>(context,listen: false);
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.grey[200],
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        child: StreamBuilder(
          stream: testsBloc.testsStream,
          builder: (context, snapshot){
            if(snapshot.data == null){
              return Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('There are no tests right now!!'),
                    ),
                    RaisedButton(
                      child: Text('Add Tests'),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddTestForm()));
                      },
                    )
                  ],
                ),
              );
            }
            else if(snapshot.hasData){
              List<Test> _tests = snapshot.data;
              testsBloc.printStreamData();
              return ListView.builder(
                itemCount: _tests.length + 1,
                itemBuilder: (context, index){
                  return index == 0 ? RaisedButton(
                    onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => AddTestForm()
                          )
                      );
                    },
                    child: Text('+' + ' ' + 'Add Test', style: TextStyle(fontSize: 20, color: Colors.blue),),
                  ) : Container(
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 7),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey
                          )
                        ]
                    ),
                    child: ListTile(
                      subtitle: Text('${_tests.elementAt(index-1).level}'),
                      title: Text('${_tests.elementAt(index - 1).title}', style: GoogleFonts.varelaRound(fontSize: 20),),
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TestVisualize(test: _tests.elementAt(index-1),)
                          )
                        );
                      },
                    ),
                  );
                },
              );
            }else if(snapshot.hasError){
              return Center(child: Text('${snapshot.error}'),);
            }return Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
}
