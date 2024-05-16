import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_final/pages/homescreen.dart';
import 'package:firebase_final/pages/signup.dart';
import 'package:firebase_final/utils/variables.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();

  login() {
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailcontroller.text, 
      password: passwordcontroller.text
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      body: Container(
        width: double.infinity,
        height: double.infinity,
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

            SizedBox(
              width: 225,
              height: 45,
              child: ElevatedButton(
                onPressed: () {login();},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red[400]!),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                child: Text('Login',
                  style:  myStyle(22, Colors.white, FontWeight.bold),
                ),
              ),  
            ),
            
            SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Don\'t have an account?',
                  style: myStyle(18, Colors.white60),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context) => SignUp()),
                    );
                  },
                  child: Text('Register',
                    style: myStyle(18, Colors.red[400]!, FontWeight.bold),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}