import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_final/utils/variables.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';

class CommentPage extends StatefulWidget {
  final String documentId;
  CommentPage(this.documentId);
  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  var commentController = TextEditingController();

  addComment() async {
    var firebaseuser = await FirebaseAuth.instance.currentUser;
    DocumentSnapshot userdoc = await usercollection.doc(firebaseuser!.uid).get();
    pathcollection.doc(widget.documentId).collection('comments').doc().set({
      'comment': commentController.text,
      'username': userdoc['username'],
      'uid': firebaseuser.uid,
      'pic': userdoc['profilepic'],
      'time': Timestamp.now(),
    });
    DocumentSnapshot commentcount = await pathcollection.doc(widget.documentId).get();

    pathcollection.doc(widget.documentId).update({
      'commentcount': commentcount['commentcount'] + 1,
    });
    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[700],
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, size: 32, color: Colors.white),
        ),
        centerTitle: true,
        title: Text('Comments', style: myStyle(40, Colors.white, FontWeight.bold)),
      ),

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: pathcollection.doc(widget.documentId).collection('comments').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot commentdoc = snapshot.data!.docs[index];
                      return Card(
                        color: Colors.white,
                        margin: EdgeInsets.only(top: .75, bottom: .75),
                        shape: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 1)),
                        child: ListTile(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(commentdoc['pic']),
                          ),
                          title: Text(commentdoc['username'], style: myStyle(18, Colors.black, FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(commentdoc['comment'], style: myStyle(16, Colors.black)),
                              const SizedBox(height: 6),
                              Text(timeago.format(commentdoc['time'].toDate()).toString(), style: myStyle(14, Colors.grey)),
                            ],
                          ),
                        ),
                      );
                    }
                  );
                },
              ),
            ),
            Divider(),
            ListTile(
              title: TextFormField(
                controller: commentController,
                decoration: InputDecoration(
                  hintText: 'Add a comment...',
                  hintStyle: myStyle(18, Colors.black),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red[400]!)
                  ),
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.send, size: 30, color: Colors.red[400]),
                onPressed: () {addComment();},
              ),
            ),
          ],
        ),
      ),
    );
  }
}