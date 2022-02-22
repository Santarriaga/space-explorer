import 'package:flutter/material.dart';
import 'package:space_explorer/screens/explore.dart';
import 'package:space_explorer/screens/favorites.dart';
import 'package:space_explorer/screens/home.dart';
import 'package:space_explorer/wrapper.dart';
import '../database/auth_service.dart';


class MainDrawer extends StatelessWidget {
   MainDrawer({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF282157),
              ),
              child: Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/spaceship.png',
                      height: 75,
                      width: 75,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                        "Space Explorer",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text(
                "Home",
              style: TextStyle(
                fontSize: 18
              ),
            ),
            onTap: (){
              Navigator.pop(context);
              Navigator.push(context,MaterialPageRoute(builder: (context)=> const Home()));
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey[800],
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text(
                "Favorites",
              style: TextStyle(
                  fontSize: 18
              ),
            ),
            onTap: (){
              Navigator.pop(context);
              Navigator.push(context,MaterialPageRoute(builder: (context)=> const FavoritesScreen()));
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey[800],
          ),
          ListTile(
            leading: const Icon(Icons.api),
            title: const Text(
                "Explore",
              style: TextStyle(
                  fontSize: 18
              ),
            ),
            onTap: (){
              Navigator.pop(context);
              Navigator.push(context,MaterialPageRoute(builder: (context)=>  const ExploreScreen()));
            },
          ),
          Divider(
            height: 0,
            color: Colors.indigo[900],
          ),
          ListTile(
            leading: const Icon(Icons.arrow_back),
            title: const Text(
                "Sign out",
              style: TextStyle(
                  fontSize: 18
              ),
            ),
            onTap: () async {
              Navigator.pop(context);
              await _auth.signOut();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext builder) => const Wrapper() ), (route) => false);
            },
          ),
          Divider(
            height: 1,
            color: Colors.grey[800],
          ),
        ],
      ),
    );
  }



}
