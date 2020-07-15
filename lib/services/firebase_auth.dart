import 'package:firebase_auth/firebase_auth.dart';
import 'package:heutagogy_web/models/user_class.dart';


class Auth{

  final auth = FirebaseAuth.instance;

  User userFromFirebase(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;  
  }

  Stream get isSignedIn => auth.onAuthStateChanged.map(userFromFirebase);
  
  Future<User> createUser() async{
    try{
      AuthResult result = await auth.createUserWithEmailAndPassword(email: 'rajbackservices@gmail.com', password: 'ApGOV@123');
      FirebaseUser user = result.user;
      return userFromFirebase(user);
    }catch(e){
      print(e.toString());
      throw Exception('$e');
    }
  }

  Future<User> signInWithEmail({String email, String password}) async {
    try{
      AuthResult result = await auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return userFromFirebase(user);
    }catch(e){
      print('$e');
      throw Exception('$e');
    }
  }

  Future<void> signOut() async{
    try{
      await auth.signOut();
    }catch(e){
      throw Exception('FAILED TO SIGN OUT : $e');
    }
  }

}