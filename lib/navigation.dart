import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_final/pages/homescreen.dart';
import 'package:firebase_final/pages/signup.dart';
import 'package:firebase_final/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'pages/login.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  bool isSigned = false;
  @override

  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        setState(() {
          isSigned = true;
        });
      } else {
        setState(() {
          isSigned = false;
        });
      }
    });
  }

  Widget build (BuildContext context) {
    return Scaffold(
      body: isSigned == false ? Login() : HomeScreen(),
    );
  }
}


