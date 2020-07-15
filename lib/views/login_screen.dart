import 'package:flutter/material.dart';
import 'package:heutagogy_web/models/user_class.dart';
import 'package:heutagogy_web/services/firebase_auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width/2,
          height: MediaQuery.of(context).size.height/2,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: TextFormField(
                    controller: _emailController,
                    validator: (String value){
                      if(value.isEmpty){
                        return "This Field is Required";
                      }return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email'
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    validator: (String value){
                      if(value.isEmpty){
                        return "this field is required!!";
                      }return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text('Login'),
                  onPressed: () async{
                    _formKey.currentState.validate();
                    if(_formKey.currentState.validate()){
                      Auth  _auth = Provider.of<Auth>(context, listen: false);
                      User user = await _auth.signInWithEmail(email: _emailController.text, password: _passwordController.text);
                      return user;
                    }
                    _passwordController.clear();
                    _emailController.clear();
                    return null;
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
