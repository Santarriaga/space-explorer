import 'package:flutter/material.dart';
import 'package:space_explorer/models/picture.dart';

class FavoriteDetails extends StatelessWidget {
  const FavoriteDetails({Key? key,required this.image}) : super(key: key);

  final Picture image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
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
            Container(
              child:  image.imageUrl!=null ? Image.network(image.imageUrl ?? ''):image.mediaType=="video" ? const Text("image is not available") : const Text("Waiting For the picture"),
            ),
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
          ],
        ),
      ),
    );
  }
}
