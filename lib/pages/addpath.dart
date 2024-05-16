import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_final/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPath extends StatefulWidget {
  const AddPath({super.key});

  @override
  State<AddPath> createState() => _AddPathState();
}

class _AddPathState extends State<AddPath> {
  TextEditingController pathController = TextEditingController();
  // File imagepath = File('');

  // pickImage(ImageSource imgsource) async {

  //   final image = await ImagePicker().pickImage(source: imgsource);
  //   setState(() {
  //     imagepath = File(image!.path);
  //   });
  //   Navigator.pop(context);
  // }

  optionsDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Choose an option', style: myStyle(20, Colors.black)),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                // pickImage(ImageSource.gallery);
              },
              child: Text('Image from Camera', style: myStyle(18, Colors.black)),
            ),
            SimpleDialogOption(
              onPressed: () {
                // pickImage(ImageSource.camera);
              },
              child: Text('Image from Gallery', style: myStyle(18, Colors.black)),
            ),
            SimpleDialogOption(
              onPressed: () {Navigator.pop(context);},
              child: Text('Cancel', style: myStyle(18, Colors.black)),
            ),
          ],
        );
      }
    );
  }

  postPath()async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    DocumentSnapshot userDoc = await usercollection.doc(firebaseUser!.uid).get();
    var allDocuments = await pathcollection.get();
    int length = allDocuments.docs.length;
    if (pathController.text != '') {
      pathcollection.doc('Path $length').set({
        'username': userDoc['username'],
        'userimage': userDoc['profilepic'],
        'useruid': firebaseUser.uid,
        'path': pathController.text,
        'time': Timestamp.now(),
        'likes': [],
        'comments': 0,
        'shares': [],
        'id': 'Path $length',
      });
      Navigator.pop(context);
    } else {
      // return showSnackBar(context, 'Please fill in the path');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {postPath();},
        child: Icon(Icons.check, size: 30, color: Colors.white),
        backgroundColor: Colors.red[400],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[700],
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, size: 32, color: Colors.white),
        ),
        centerTitle: true,
        title: Text('Forge a NEW Path', style: myStyle(30, Colors.white, FontWeight.bold)),
        actions: [
          InkWell(
            onTap: () {optionsDialog();},
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(Icons.photo, size: 32, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            
            child: TextField(
              controller: pathController,
              maxLines: 10,
              style: myStyle(18, Colors.black),
              decoration: InputDecoration(
                hintText: 'What\'s in your path?',
                hintStyle: myStyle(20, Colors.black),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(left: 20, top: 20),
              ),
            )
          ),

          // imagepath == '' ? Container() : 
          //   MediaQuery.of(context).viewInsets.bottom > 0 ? Container() :
          //   Image(
          //     image: FileImage(imagepath),
          //     height: 200,
          //     width: 200
          //   ),
        ],
      ),

      
    );
  }
}