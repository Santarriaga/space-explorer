import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:space_explorer/models/picture.dart';

import '../database/auth_service.dart';
import '../database/database_service.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({Key? key, required this.image}) : super(key: key);

  final Picture image;
  final AuthService _auth = AuthService();



  Future<void> saveToFavorites()async{
    final String uid = _auth.getUserId().toString();
    DatabaseService database = DatabaseService(uid: uid);

    await database.addImage(
      imageInfo: image.imageInfo,
      imageTitle: image.imageTitle,
      imageUrl:  image.imageUrl,
      mediaType: image.mediaType,
    );

    Fluttertoast.showToast(
        msg: "Saved to favorites",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Image Details"),
        backgroundColor: const Color(0xFF282157),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
        child: ListView(
          children: <Widget>[
            Text(
              image.imageTitle ?? 'No title provided',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white
              ),
            ),
            const Padding(
                padding: EdgeInsets.only(bottom: 20)
            ),
            Image.network(image.imageUrl ?? 'Image not available'),
            const Padding(padding: EdgeInsets.only(bottom: 20),
            ),
            Text(
              image.imageInfo ?? 'No information found',
              style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  color: Colors.white
              ),
            ),
            ElevatedButton(
              style:  ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xFF282157))
              ),
                onPressed: (){
                  saveToFavorites();
                },
                child: const Text("Save")
            )

          ],
        ),
      ),
    );
  }
}
