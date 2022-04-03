import 'dart:async';
import 'package:blooddonation/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostReject extends StatefulWidget {
  PostRejectState createState() => PostRejectState();
}
class PostRejectState extends State<PostReject> {
  StreamSubscription<QuerySnapshot> _subscription;
  List<DocumentSnapshot> postList;
  final Query _collectionReference = FirebaseFirestore.instance
      .collection("post")
      .where("appending", isEqualTo: "Reject");

  @override
  void initState() {
    super.initState();
    _subscription = _collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        postList = datasnapshot.docs;
        print("Posts List ${postList.length}");
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: defaultPostsAppBar(context, 'Post\'s Rejected'),
        body:  Column(children: [
          Flexible(
              child: postList != null
                  ? Card(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  color: Color.fromRGBO(254, 199, 199, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(
                      color: Colors.black26,
                    ),
                  ),
                  child: ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: ((context, index) {
                        return defaultPosts(
                          img: postList[index].data()['img'],
                          name: postList[index].data()['name'],
                          description: postList[index].data()['postdescribtion'],
                          padding: Padding(padding: EdgeInsets.all(0.0)),
                        );
                      })))
                  : Center(
                child: CircularProgressIndicator(),
              ))
        ]));
  }
}
