
import 'package:firebase_auth/firebase_auth.dart';
import 'package:space_explorer/models/my_user.dart';


/// Class that calls firebase instance to check user authentication
class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create MyUser object based on firebase user
  MyUser? _userFromFirebase (User? user){
    return user != null ? MyUser(uid: user.uid) : null;
  }

  String? getUserId(){
    User? user = _auth.currentUser;
    return user?.uid.toString();
  }

  //setup auth stream to detect authentication changes
  Stream<MyUser?> get user{
    return _auth.authStateChanges().map((User? user) => _userFromFirebase(user));
  }


  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      //creates user with email and password
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      //create a new document for the user with the uid
      //await DatabaseService(uid: user!.uid).addUser();

      return _userFromFirebase(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  ///sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      //sign in user with email and password
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      return _userFromFirebase(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }


  ///sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}