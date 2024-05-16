import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_final/pages/comments.dart';
import 'package:firebase_final/utils/variables.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
String uid = '';
Stream userstream = Stream.empty();
String username = '';
String userimage = '';
  
  initState() {
    super.initState();
    getcurrentuseruid();
    getstream();
    getcurrentuserinfo();
  }

  getcurrentuserinfo() async {
    var firebaseuser = await FirebaseAuth.instance.currentUser;
    DocumentSnapshot userdoc = await usercollection.doc(firebaseuser!.uid).get();
    setState(() {
      username = userdoc['username'];
      userimage = userdoc['profilepic'];
    });
  }

  getstream() async {
    var firebaseuser = await FirebaseAuth.instance.currentUser;
    setState(() {
      userstream = pathcollection.where(firebaseuser!.uid).snapshots();
    });
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
        backgroundColor: Colors.blueGrey[700],
        title: Text(username, style: myStyle(40, Colors.white, FontWeight.bold)),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(Icons.logout, size: 32, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Stack(
          children: <Widget> [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blueGrey[700]!, Colors.red[400]!],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 70,
                left: MediaQuery.of(context).size.width / 2 - 64 ,
              ),
              child: CircleAvatar(
                radius: 64,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(userimage),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 6,
              ),
              child: Column(
                children: <Widget> [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget> [
                      Text('Following', style: myStyle(18, Colors.black)),
                      Text('Followers', style: myStyle(18, Colors.black)),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget> [
                      Text('12', style: myStyle(18, Colors.black, FontWeight.bold)),
                      Text('20', style: myStyle(18, Colors.black, FontWeight.bold)),

                    ],
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black),
                        gradient: LinearGradient(
                          colors: [Colors.blueGrey[500]!, Colors.red[200]!],
                        ),
                      ),
                      child: Center(
                        child: Text('Edit Profile', style: myStyle(20, Colors.white, FontWeight.bold)),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text('User\'s Paths', style: myStyle(20, Colors.black, FontWeight.bold),),
                  Divider(
                    thickness: 2,
                  ),
                  StreamBuilder(
                    stream: userstream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
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

                ],
              ),
            ),
          ]
        )
      ),
    );
  }
}