import 'package:blooddonation/models/approve.dart';
import "package:cloud_firestore/cloud_firestore.dart";


class ApprovePost {
  final _firestore = Firestore.instance;

  Approve(String postid, PostApprove1 postapprove) {
    DocumentReference ref =
        FirebaseFirestore.instance.collection('post').doc(postid);
    ref.update({
      "appending": postapprove.appending1,
    });
  }
}
