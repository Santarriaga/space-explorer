import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:space_explorer/models/picture.dart';
import 'package:space_explorer/screens/details_screen.dart';
import '../ui/loading.dart';
import '../ui/main_drawer.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {

  final int maxCount = 10;
  List<Picture>? myList;
  bool isLoadingPage = true;
  bool isFetchingData = false;

  Future<void> getRandomImages() async{
    try{
      Response response = await get(Uri.parse("https://api.nasa.gov/planetary/apod?api_key=RDdaiSSdmdZZBw6NhLVg1jrPpdhn4gAKJ5GHRUGd&count=$maxCount"));

      final data = jsonDecode(response.body).cast<Map<String,dynamic>>();


      setState(() {
        myList = data.map<Picture>( (json) => Picture.fromJson(json)).toList();
        if(myList!.isNotEmpty){
          isLoadingPage = false;
        }
      });


    }catch(e){
      print(e.toString());
    }
  }

  Future<void> loadMoreImages() async{
    // make get request
    Response response = await get(Uri.parse("https://api.nasa.gov/planetary/apod?api_key=RDdaiSSdmdZZBw6NhLVg1jrPpdhn4gAKJ5GHRUGd&count=$maxCount"));

    //cast data to map
    final data = jsonDecode(response.body).cast<Map<String,dynamic>>();

    // convert data to list of images
    List<Picture> newList = data.map<Picture>( (json) => Picture.fromJson(json)).toList();

    //append new list to current list
    setState(() {
      myList?.addAll(newList);
      isFetchingData = false;
    });
  }

  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    getRandomImages();

    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        loadMoreImages();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoadingPage ? const Loading() : Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        backgroundColor: const Color(0xFF282157),
        elevation: 0,
      ),
      drawer: MainDrawer(),
      backgroundColor: Colors.black,
      body: ListView.builder(
        controller: scrollController,
        itemCount:  myList?.length,
        itemBuilder: (context, index){
            return Container(
              margin: const EdgeInsets.only(top: 20),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(image: myList![index])));
                },
                child: Card(
                  elevation: 10,
                  child: myList?[index].imageUrl!=null ? Image.network(myList?[index].imageUrl! ?? ''):myList?[index].mediaType=="video" ? const Text("image is not available") : const Text("Waiting For the picture"),
                ),
              ),
            );
        }),
    );
  }
}





