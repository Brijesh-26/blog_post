import 'package:flutter/material.dart';


// photourl: photoUrl,
//                               displayname: author,
//                               postId: postId,


class Liked extends StatefulWidget {
  
  String photourl, displayname, postId;
  Liked(
      {
      required this.photourl,
      required this.displayname,
      required this.postId});

  @override
  State<Liked> createState() => _LikedState();
}

class _LikedState extends State<Liked> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Liked By'),
      ),
      //  list of users who liked this post
      body: Center(child: Text('here we\'ll display the list of user who liked the post')),
    );
  }
}