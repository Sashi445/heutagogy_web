import 'package:heutagogy_web/services/firebase_auth.dart';


class CheckUserBloc{

  final _auth = Auth();

  Stream get isSignedInOrNot => _auth.isSignedIn;

}