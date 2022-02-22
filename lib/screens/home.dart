
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:space_explorer/database/auth_service.dart';
import 'package:space_explorer/database/database_service.dart';
import 'package:space_explorer/models/my_user.dart';
import 'package:space_explorer/models/picture.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../ui/main_drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();

  // variable for the current date
  Picture? img;
  String? year;
  String? month;
  String? day;
  DateTime? dateTime;
  late String uid;
  MyUser? user;
  bool liked = false;

  //function that will call the api
  Future<void> getResponse({String? year, String? month, String? day}) async{

    try{
      String date = "$year-$month-$day";

      //make network call
      Response response = await get( Uri.parse("https://api.nasa.gov/planetary/apod?date=$date&hd=true&api_key=RDdaiSSdmdZZBw6NhLVg1jrPpdhn4gAKJ5GHRUGd"));


      //decode json response
      Map data = jsonDecode(response.body);
      //print(data);

      setState(() {
        img = Picture(
            imageUrl: data['hdurl'],
            imageTitle: data['title'],
            imageInfo: data['explanation'],
            mediaType: data['media_type']
        );
        liked = false;
      });
    }catch(e){
      print("caught error: $e");
      img = null;
    }

  }

  //function that saves image of the day to favorites
  Future<void> saveToFavorites()async{
    DatabaseService database = DatabaseService(uid: uid);

    if(img?.isLiked == false){
      await database.addImage(
        imageInfo: img?.imageInfo,
        imageTitle: img?.imageTitle,
        imageUrl:  img?.imageUrl,
        mediaType: img?.mediaType,
      );
      setState(() {
        img?.isLiked = true;
        liked = true;
      });
      Fluttertoast.showToast(
          msg: "Saved to favorites",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0
      );
    }else{
      await database.removeImage(imageTitle: img?.imageTitle);
      setState(() {
        img?.isLiked = false;
        liked = false;
      });
      Fluttertoast.showToast(
          msg: "Removed from favorites",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0
      );
    }

  }

  //function lets user change data to retrieve another image
  Future<void> datePickerDialog(BuildContext context )async{
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1995,6,16,0,0),
        lastDate: DateTime.now(),
        cancelText: "Cancel",
        confirmText: "Submit"
    );

    if(dateTime!= null){
      setState(() {
        year = dateTime.year.toString();
        month = dateTime.month.toString();
        day = dateTime.day.toString();
      });
    }
    getResponse(year: year, month: month, day: day);
  }


  //function checks if image is already in database
  Future<void> searchForImage(String? title) async{
    DatabaseService database = DatabaseService(uid: uid);
    bool found = await database.searchInFavorites(title!);
    if(found){
      setState(() {
        liked = true;
      });
    }
  }



  @override
  void initState() {
    super.initState();
    uid = _auth.getUserId()!;
    dateTime = DateTime.now();
    year = dateTime?.year.toString();
    month = dateTime?.month.toString();
    day = dateTime?.day.toString();

    getResponse(year: year,month: month, day: day);
  }



  @override
  Widget build(BuildContext context) {
    searchForImage(img?.imageTitle);

    return Scaffold(
      drawer: MainDrawer(),
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Picture of the day'),
        backgroundColor: const Color(0xFF282157),
        elevation: 0,
        actions: [
          TextButton.icon(
            icon:  const Icon(
            Icons.calendar_today,
            color: Colors.white
            ),
            onPressed: ()async{
              await datePickerDialog(context);
            },
            label: Text(
              '$year-$month-$day',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          saveToFavorites();

        },
        child: Icon(
          Icons.favorite,
          color: liked ? Colors.red : Colors.grey
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
        child: ListView(
          children: <Widget>[
            Text(
              img?.imageTitle ?? 'No title provided',
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
              child: img?.imageUrl!=null ? Image.network(img?.imageUrl! ?? ''):img?.mediaType=="video"?const Text("image is not available", style: TextStyle(color: Colors.white)) : const Text("Waiting For the picture"),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 20),
            ),
            Text(
              img?.imageInfo ?? 'No information found',
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
