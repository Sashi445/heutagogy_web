import 'package:flutter/material.dart';
import 'package:heutagogy_web/views/home_page.dart';
import 'package:heutagogy_web/views/login_screen.dart';
import 'package:heutagogy_web/blocs/on_auth_changed_bloc.dart';

class Root extends StatelessWidget {
  CheckUserBloc _userBloc = CheckUserBloc();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _userBloc.isSignedInOrNot,
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
          return LoginScreen();
        }
       else if(snapshot.hasData){
          return HomeScreen();
        }else if(snapshot.hasError){
          return Center(child: Text(snapshot.error),);
        }return Center(child: CircularProgressIndicator(),);
      },
    );
  }
}
