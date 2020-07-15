import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heutagogy_web/blocs/add_questions_bloc.dart';
import 'package:heutagogy_web/models/option_class.dart';
import 'package:heutagogy_web/models/question_class.dart';
import 'package:heutagogy_web/models/test_class.dart';
import 'package:heutagogy_web/views/forms/add_test_form.dart';
import 'package:heutagogy_web/views/tests_viewer.dart';
import 'package:provider/provider.dart';
import 'package:heutagogy_web/views/widgets/common_widgets.dart';

class AddQuestion extends StatefulWidget {
  Test test;
  AddQuestion({this.test});

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();

  final _questionController = TextEditingController();

  List<TextEditingController> _controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  List<Question> questions = [];

  int _groupValue = -1;

  List<Widget> optionBuilder(){
    List<Widget> _options = [];
    for(int i=0; i<4; i++){
      _options.add(
        RadioListTile(
          title: TextFormField(
            controller: _controllers.elementAt(i),
            validator: (String value){
              if(value.isEmpty){
                return "this field is required!!";
              }return null;
            },
            decoration: InputDecoration(
              labelText: 'Option ${i + 1}'
            ),
          ),
          value: i,
          groupValue: _groupValue,
          onChanged: (int value){
            setState(() {
              _groupValue = value;
            });
          },
        ),
      );
    }
    return _options;
  }

  @override
  Widget build(BuildContext context) {
    AddQuestionsBloc questionsBloc = Provider.of<AddQuestionsBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.grey[200],
      body: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width/2,
            child: StreamBuilder(
              stream: questionsBloc.questionsStream,
              builder: (context, snapshot){
                if(snapshot.data == null){
                  return Center(child: Text('Add questions start entering!!'),);
                }
                if(snapshot.hasData && snapshot.data != null){
                  List<Question> _questions = snapshot.data;
                  return ListView.builder(
                    itemCount: _questions.length + 1,
                    itemBuilder: (context, index){
                      return index == 0 ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${widget.test.title}', style: GoogleFonts.varelaRound(fontSize: 30),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${widget.test.introText}',),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${widget.test.level}'),
                            )
                          ],
                        ),
                      ) : QuestionViewer(question: _questions.elementAt(index - 1),);
                    },
                  );
                }else if(snapshot.hasError){
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          VerticalDivider(
            endIndent: MediaQuery.of(context).size.height/12,
            indent: MediaQuery.of(context).size.height/12,
            thickness: 1,
            color: Colors.black,
            width: 10,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width/2 - 10,
            child:Form(
                  key: _formKey,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey
                        )
                      ]
                    ),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Enter your question here!!'
                          ),
                          controller: _questionController,
                          validator: (String value){
                            if(value.isEmpty){
                              return "this field is required!!";
                            }return null;
                          },
                        ),
                        Column(
                          children: optionBuilder(),
                        ),
                        ButtonBar(
                          children: [
                            RaisedButton(
                              child: Text('Done'),
                              color: Colors.blue,
                              onPressed: (){
                                if(_formKey.currentState.validate()){
                                  int i=0;
                                  Question question = Question(
                                    question: _questionController.text,
                                    options: _controllers.map((e){
                                      Option option = Option(text: e.text, value: i==_groupValue ? true : false);
                                      i++;
                                      return option;
                                    }).toList()
                                  );
                                  questions.add(question);
                                  questionsBloc.onData(question: question);
                                  _questionController.clear();
                                  _controllers.map((e) => e.clear()).toList();
                                }
                              },
                            )
                          ],
                        ),
                        RaisedButton(
                          color: Colors.blue,
                          child: Text('Stage Changes'),
                          onPressed: (){
                            Test test = Test(
                              title: widget.test.title,
                              introText: widget.test.introText,
                              level: widget.test.level,
                              questions: questions
                            );
                            questionsBloc.addQuestionToTest(context: context, test: test);
                            questionsBloc.clearQuestions();
                          },
                        )
                      ],
                    ),
                  ),
                )
          )
        ],
      ),
    );
  }
}



