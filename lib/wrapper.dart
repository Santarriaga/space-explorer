import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_explorer/screens/home.dart';

import 'authentication/authenticate.dart';
import 'models/my_user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //access user data from the provider
    final user = Provider.of<MyUser?>(context);

    if(user == null){
      return const Authenticate();
    }else{
      return const Home();
    }

  }
}
