import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_explorer/database/auth_service.dart';
import 'package:space_explorer/database/database_service.dart';
import 'package:space_explorer/models/picture.dart';
import '../ui/image_list.dart';
import '../ui/main_drawer.dart';


class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  final AuthService _auth = AuthService();
  late final uid;

  @override
  void initState() {
    super.initState();
    uid = _auth.getUserId();

  }

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Picture>?>.value(
      value: DatabaseService(uid: uid ).images,
      initialData: [],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: const Color(0xFF282157),
          title: const Text("Favorites"),
          elevation: 0,
        ),
        drawer: MainDrawer(),
        body: const ImageList(),
      ),
    );


  }

}
