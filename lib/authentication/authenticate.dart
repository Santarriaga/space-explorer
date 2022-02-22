
import 'package:flutter/material.dart';
import 'package:space_explorer/authentication/register.dart';
import 'package:space_explorer/authentication/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  //switch between true or false
  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }


  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleView: toggleView);
    }else{
      return Register(toggleView: toggleView);
    }
  }
}
