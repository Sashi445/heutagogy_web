
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heutagogy_web/services/firebase_auth.dart';
import 'package:heutagogy_web/views/school_register_form.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Heutagogy'),
        actions: [
          IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: ()async{
              await Provider.of<Auth>(context, listen: false).signOut();
            },
          )
        ],
      ),
      body: Row(
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          children: [
            Icon(Icons.add),
            Text('Add School', style: GoogleFonts.varelaRound(fontSize: 18),),
          ],
        ),
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SchoolRegisterForm()
            )
          );
        },
      ),
    );
  }
}
