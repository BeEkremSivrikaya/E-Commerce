import 'package:e_commerce_app/helper/firebase_helper.dart';
import 'package:e_commerce_app/utility/comment.dart';
import 'package:flutter/material.dart';

class CommentCard extends StatefulWidget {
  Comment? comment;

  CommentCard({this.comment});

  @override
  State<CommentCard> createState() => _CommentCardState(comment: comment);
}

class _CommentCardState extends State<CommentCard> {
  Comment? comment;

  _CommentCardState({this.comment});

  String? name = "loading...";
  getUserName() {
    FirebaseHelper()
        .firestoreGet("Person", widget.comment!.userId!)
        .then((doc) {
      setState(() {
        name = doc["name"];
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(
          5,
        ),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(5)),
            width: 200,
            height: 70,
            // color: Color.fromARGB(255, 162, 160, 160),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                  width: 10,
                ),
                Text(
                  "Kullanıcı Adı: " + name!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(widget.comment!.comment!),
              ],
            )),
      ),
    );
  }
}
