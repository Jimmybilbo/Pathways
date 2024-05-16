import 'package:firebase_final/pages/navbar/paths.dart';
import 'package:firebase_final/pages/navbar/profile.dart';
import 'package:firebase_final/pages/navbar/search.dart';
import 'package:firebase_final/pages/comments.dart';
import 'package:firebase_final/utils/variables.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int page = 0;
  List pageoptions = [
    PathsPage(),
    SearchPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pageoptions[page],
      ),

      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        selectedItemColor: Colors.red[400],
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.blueGrey[700],
        currentIndex: page,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: 'Paths', 
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 30,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}