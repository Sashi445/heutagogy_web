import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heutagogy_web/models/test_class.dart';
import 'package:heutagogy_web/views/forms/add_questions_form.dart';

class AddTestForm extends StatefulWidget {

  @override
  _AddTestFormState createState() => _AddTestFormState();
}

class _AddTestFormState extends State<AddTestForm> {

  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();

  final _introTextController = TextEditingController();

  int _groupValue = -1;

  List<String> _levels = [
    'basic',
    'intermediate',
    'advanced'
  ];

  List<Widget> _levelBuilder(){
    List<Widget> _levelRadios = [];
    for(int i=0; i<_levels.length; i++){
      _levelRadios.add(
          RadioListTile(
            title: Text('${_levels.elementAt(i)}'),
            groupValue: _groupValue,
            value: i,
            onChanged: (int value){
              setState(() {
                _groupValue = value;
              });
            },
          )
      );
    }
    return _levelRadios;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width*3/4,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text('Add Test', style: GoogleFonts.varelaRound(fontSize: 37),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autofocus: true,
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Enter the title of the test',
                  ),
                  validator: (String value){
                    if(value.isEmpty){
                      return "This field is required!!";
                    }return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _introTextController,
                  decoration: InputDecoration(
                    labelText: 'Describe the test',
                  ),
                  validator: (String val){
                    if(val.isEmpty){
                      return "This field is required!!";
                    }return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Select the level of the test', style: GoogleFonts.varelaRound(fontSize: 30),),
              ),
              Column(
                children: _levelBuilder(),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            if(_formKey.currentState.validate()){
              Test test = Test(
                title: _titleController.text,
                introText: _introTextController.text,
                level: _levels.elementAt(_groupValue),
                questions: []
              );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddQuestion(test: test,)
                )
              );
            }
          },
          label: Row(
            children: [
              Text('Next'),
              Icon(Icons.arrow_forward)
            ],
          )
      ),
    );
  }
}
