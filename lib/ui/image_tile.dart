import 'package:flutter/material.dart';
import 'package:space_explorer/models/picture.dart';
import 'package:space_explorer/screens/favorite_details.dart';

class ImageTile extends StatelessWidget {
  const ImageTile({Key? key, required this.image}) : super(key: key);

  final Picture image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteDetails(image: image)));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          ),
          elevation: 15,
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Image.network(image.imageUrl!),
          shadowColor: Colors.white,
          ),
      ),
    );
  }
}

