import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heutagogy_web/models/school_class.dart';
import 'package:heutagogy_web/views/class_viewer.dart';

class SchoolRegisterForm extends StatefulWidget {
  @override
  _SchoolRegisterFormState createState() => _SchoolRegisterFormState();
}

class _SchoolRegisterFormState extends State<SchoolRegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final _schoolNameController = TextEditingController();

  School school = School();

  List<String> _schoolTypes = [
    'ICSE',
    'CBSE',
    'Stateboard'
  ];

  int _groupValue = -1;

  List<Widget> _radioBuilder(){
    List<Widget> radios = [];
    for(int i=0; i<_schoolTypes.length; i++){
      radios.add(ListTile(
        leading: Radio(
          value: i,
          groupValue: _groupValue,
          onChanged: (int value){
            setState(() {
              _groupValue = value;
            });
          },
        ),
        title: Text('${_schoolTypes.elementAt(i)}'),
      ));
    }
    return radios;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(30),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width/2,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Welcome!!', style: GoogleFonts.varelaRound(fontSize: 40),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _schoolNameController,
                        validator: (String value){
                          if(value.isEmpty){
                            return "this field is required!!";
                          }return null;
                        },
                        style: GoogleFonts.varelaRound(fontSize: 30),
                        autofocus: true,
                        decoration: InputDecoration(
                          labelText: 'Enter Your School Name',
                          labelStyle: GoogleFonts.varelaRound(fontSize: 20)
                        ),
                      ),
                    ),
                    Text('Choose the curriculum of the school', style: GoogleFonts.varelaRound(fontSize: 35),),
                    Container(
                      width: MediaQuery.of(context).size.width/4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _radioBuilder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          if(_formKey.currentState.validate()){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ClassViewer()
              )
            );
          }
        },
        label: Row(
          children: [
            Text('Next'),
            Icon(Icons.arrow_forward)
          ],
        ),
      ),
    );
  }
}