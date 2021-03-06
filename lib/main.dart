import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_explorer/database/auth_service.dart';
import 'package:space_explorer/wrapper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value: AuthService().user,
        initialData: null,
        child:  const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Wrapper(),
        ),
    );
  }
}




