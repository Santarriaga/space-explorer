
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_explorer/database/auth_service.dart';
import 'package:space_explorer/database/database_service.dart';
import 'package:space_explorer/models/picture.dart';
import 'image_tile.dart';

class ImageList extends StatefulWidget {
  const ImageList({Key? key}) : super(key: key);

  @override
  _ImageListState createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {

  final AuthService _auth = AuthService();
  late String uid;


  @override
  void initState() {
    super.initState();
    uid = _auth.getUserId()!;
  }

  Future<void> removeItem(String title) async{
    DatabaseService database = DatabaseService(uid: uid);
    await database.removeImage(imageTitle: title);
  }

  @override
  Widget build(BuildContext context) {

    final list = Provider.of<List<Picture>?>(context) ?? [];

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context,index){
        final item = list[index];
        return Dismissible(
            key: Key(item.imageTitle.toString()),
            onDismissed: (direction) async{
              await removeItem(list[index].imageTitle.toString());

              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Image Removed"))
              );
            },
            background: Container(
              color: Colors.grey[100],
              child: const Icon(
                Icons.delete,
                size: 80
              ),
            ),
            child: ImageTile( image: list[index])
        );

       // return ImageTile(image: list[index]);
      }
    );
  }
}
