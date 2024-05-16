import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_final/pages/addpath.dart';
import 'package:firebase_final/pages/comments.dart';
import 'package:firebase_final/utils/variables.dart';
import 'package:flutter/material.dart';

class PathsPage extends StatefulWidget {
  const PathsPage({super.key});

  @override
  State<PathsPage> createState() => _PathsPageState();
}

class _PathsPageState extends State<PathsPage> {
  String uid = '';
  
  initState() {
    super.initState();
    getcurrentuseruid();
  }

  getcurrentuseruid() async {
    var firebaseuser = await FirebaseAuth.instance.currentUser;
    setState(() {
      uid = firebaseuser!.uid;
    });
  }
  
  likePost(String documentId) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    DocumentSnapshot docu = await pathcollection.doc(documentId).get();

    if (docu['likes'].contains(firebaseUser!.uid)) {
      pathcollection.doc(documentId).update({
        'likes': FieldValue.arrayRemove([firebaseUser.uid])
      });
    } else {
      pathcollection.doc(documentId).update({
        'likes': FieldValue.arrayUnion([firebaseUser.uid])
      });
    }
  }

  sharePost(String documentId) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    DocumentSnapshot docu = await pathcollection.doc(documentId).get();

    if (docu['shares'].contains(firebaseUser!.uid)) {
      pathcollection.doc(documentId).update({
        'shares': FieldValue.arrayRemove([firebaseUser.uid])
      });
    } else {
      pathcollection.doc(documentId).update({
        'shares': FieldValue.arrayUnion([firebaseUser.uid])
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Paths', style: myStyle(40, Colors.white, FontWeight.bold)),
        backgroundColor: Colors.blueGrey[700],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddPath()));
        },
        child: Icon(Icons.add, size: 30, color: Colors.white),
        backgroundColor: Colors.red[400],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),

      body: StreamBuilder(
        stream: pathcollection.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot pathDoc = snapshot.data!.docs[index];
              return Card(
                color: Colors.white,
                margin: EdgeInsets.only(top: .75, bottom: .75),
                shape: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 1)),
                child: ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(pathDoc['userimage']),
                  ),
                  title: Text(pathDoc['username'], style: myStyle(18, Colors.black, FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(pathDoc['path'], style: myStyle(16, Colors.black)),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              InkWell(
                                onTap: () {likePost(pathDoc['id']);},
                                child: pathDoc['likes'].contains(uid)
                                ? Icon(Icons.favorite, color: Colors.red[400])
                                : Icon(Icons.favorite_border, color: Colors.red[400])
                              ),
                              SizedBox(width: 6),
                              Text(pathDoc['likes'].length.toString(), style: myStyle(14, Colors.black),),
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage(pathDoc['id'])));
                                },
                                child: Icon(Icons.comment_outlined, color: Colors.red[400],)
                              ),
                              SizedBox(width: 6),
                              Text(pathDoc['commentcount'].toString(), style: myStyle(14, Colors.black),),
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {sharePost(pathDoc['id']);},
                                child: pathDoc['shares'].contains(uid)
                                ? Icon(Icons.repeat_on_outlined, color: Colors.red[400])
                                : Icon(Icons.repeat, color: Colors.red[400],)
                              ),
                              SizedBox(width: 6),
                              Text(pathDoc['shares'].length.toString(), style: myStyle(14, Colors.black),),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
          
                    ],
                  
                  ),
                ),
              );
            },
          );
        }
      ),

    );
  }
}