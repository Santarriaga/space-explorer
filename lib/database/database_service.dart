import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:space_explorer/models/picture.dart';

class DatabaseService{
  String uid;
  late CollectionReference users;

  //constructor
  DatabaseService({required this.uid}){
    users = FirebaseFirestore.instance.collection(uid);
  }



  // function to add image information to database
  Future<void> addImage({String? imageUrl, String? imageInfo, String? imageTitle,String? mediaType})async{
     await users.doc(imageTitle).set({
      'imageUrl': imageUrl,
      'imageInfo': imageInfo,
      'imageTitle': imageTitle,
      'mediaType': mediaType,
     });
  }

  //function to remove image information from database
  Future<void> removeImage({String? imageTitle}) async{
    await users.doc(imageTitle).delete();
  }

  //image list from snapshot
  List<Picture> _imageListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return Picture(
        imageTitle: doc.get('imageTitle') ?? "No image title found",
        imageUrl: doc.get('imageUrl') ?? "No image found",
        mediaType: doc.get('mediaType'),
        imageInfo: doc.get('imageInfo'),
        );
    }).toList();
  }
  
  Stream<List<Picture>> get images {
    return users.snapshots().map((QuerySnapshot snapshot) => _imageListFromSnapshot(snapshot));
  }

  //checks to see if image is already in database
  Future<bool> searchInFavorites(String title)async{

    bool inFavorites = false;

    await users.get().then( (snapshot) =>
      snapshot.docs.forEach((doc) {
        if(doc['imageTitle'] == title){
          inFavorites = true;
        }
      })
    );
    return inFavorites;
  }


}