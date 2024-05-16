import 'package:firebase_auth/firebase_auth.dart'; // Import the necessary package

import 'package:firebase_final/navigation.dart';
import 'package:firebase_final/utils/variables.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var usernamecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var confirmpasswordcontroller = TextEditingController();

  signup() {
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailcontroller.text, 
      password: passwordcontroller.text
    ).then((signeduser) {
      usercollection.doc(signeduser.user!.uid).set({
        'username': usernamecontroller.text,
        'email': emailcontroller.text,
        'password': passwordcontroller.text,
        'profilepic': 'https://static.vecteezy.com/system/resources/previews/026/619/142/original/default-avatar-profile-icon-of-social-media-user-photo-image-vector.jpg',

      });
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 100),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
        
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/icon/app.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
        
              Stack(
                children: <Widget>[
                  Align(
                    
                    alignment: Alignment.topCenter,
                    child: Text('Pathways',
                    style: TextStyle(
                      fontSize: 85, 
                      fontFamily: 'OleoScriptSwashCaps', 
                      color: Colors.white, 
                    ),
                    ),
                  ),
        
                  Align(
                    widthFactor: 1.5,
                    heightFactor: 4.0,
                    alignment: Alignment.bottomCenter,
                    child: Text('Nontoxic, Simple Sharing', 
                    style: myStyle(20, Colors.white60),
                    ), 
                  ),
                  
                ],
              ),
        
              SizedBox(height: 20),
              
              Container(
                width: 350,
                height: 60,
                child: TextField(
                  controller: usernamecontroller,
                  keyboardType: TextInputType.emailAddress,
                  style: myStyle(18, Colors.red[400]!, FontWeight.bold),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Username',
                    prefixIcon: Icon(Icons.person),
                    hintStyle: myStyle(18, Colors.red[400]!, FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
        
              SizedBox(height: 10),
        
              Container(
                width: 350,
                height: 60,
                child: TextField(
                  controller: emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  style: myStyle(18, Colors.red[400]!, FontWeight.bold),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    hintStyle: myStyle(18, Colors.red[400]!, FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
        
              SizedBox(height: 10),
        
              Container(
                width: 350,
                height: 60,
                child: TextField(
                  controller: passwordcontroller,
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  style: myStyle(18, Colors.red[400]!, FontWeight.bold),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    hintStyle: myStyle(18, Colors.red[400]!, FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
        
              SizedBox(height: 10),
        
              Container(
                width: 350,
                height: 60,
                child: TextField(
                  controller: confirmpasswordcontroller,
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  style: myStyle(18, Colors.red[400]!, FontWeight.bold),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Confirm Password',
                    prefixIcon: Icon(Icons.check),
                    hintStyle: myStyle(18, Colors.red[400]!, FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
        
              SizedBox(height: 10),
        
              SizedBox(
                width: 225,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {signup();},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red[400]!),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  child: Text('Sign Up',
                    style:  myStyle(22, Colors.white, FontWeight.bold),
                  ),
                ),  
              ),
              
              SizedBox(height: 30),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Have an account?',
                    style: myStyle(18, Colors.white60),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: Text('Login',
                      style: myStyle(18, Colors.red[400]!, FontWeight.bold),
                    ),
                  ),
                ],
              ),
        
            ],
          ),
        ),
      ),
    );
  }
}