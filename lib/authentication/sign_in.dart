
import 'package:flutter/material.dart';
import '../database/auth_service.dart';
import '../ui/loading.dart';
import '../ui/text_input_decoration.dart';


class SignIn extends StatefulWidget {
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  final Function toggleView;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field states
  String email = '';
  String password = '';
  String error  = '';


  @override
  Widget build(BuildContext context) {
    return loading ?   const Loading() : Scaffold (
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF54526A),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.transparent,
              Colors.black,
            ]
          )
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 75),
              Image.asset(
                'assets/spaceship.png',
                height: 100,
                width: 100,
                color: Colors.white,
              ),
              const Text(
                "User Login",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                ),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.lock)
                ),
                validator: (val) => val!.length < 6 ? 'Enter an password 6+ characters long' : null,
                obscureText: true, //good for passwords
                onChanged: (val){
                  setState(() {
                    password =  val;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async{
                  if(_formKey.currentState!.validate()){
                    setState(() {
                      loading= true;
                    });
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        error = 'Could not Sign in with the current credentials';
                        loading = false;
                      });
                    }
                  }
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xFF282157)),
                ),
              ),
              TextButton(
                  onPressed: (){
                    widget.toggleView();
                  },
                  child: const Text(
                      "Don't have an account. Register Here",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  )
              ),
              const SizedBox(height: 20),
              Text(
                error,
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 14
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
