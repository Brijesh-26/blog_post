import 'package:blog_post/home.dart';
import 'package:blog_post/new_post.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class Desc extends StatefulWidget {
  String desc, photourl, displayname, postId;
  Desc(
      {required this.desc,
      required this.photourl,
      required this.displayname,
      required this.postId});

  @override
  State<Desc> createState() => _DescState();
}

class _DescState extends State<Desc> {

  TextEditingController comment = TextEditingController();

  submitCommentToDb(String comment) {
    Navigator.pop(context);

    

    // databaseRef.child(widget.postId).child(DateTime.now().millisecondsSinceEpoch.toString()).set({

    //   'comment': comment
    // }).then((value) {

    //   Fluttertoast.showToast(msg: 'comment added successfully');

    //   Navigator.pop(context);
    // }).onError((error, stackTrace) {

    //   Fluttertoast.showToast(
    //       msg:
    //           'issues regarding posting blog!!! Please check internet connection');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => MyHomePage()),
                );
              },
              child: Icon(Icons.arrow_back)),
          backgroundColor: Color.fromARGB(255, 180, 178, 178),
          title: Text(
            'Comments',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          )),
      body: Column(
        children: [
          desc_in_comment(),

          // fetch comment from firebase using post id(in realtime database)
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            popDialog();
          },
          child: Icon(Icons.add)),
    );
  }

  popDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            contentPadding: EdgeInsets.only(
              top: 10.0,
            ),
            title: Text(
              "Your Thoughts",
              style: TextStyle(fontSize: 24.0),
            ),
            content: Container(
              height: 250,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: comment,
                        maxLines: 4,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Your comment goes here.........',
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          submitCommentToDb(comment.text.toString());
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          // fixedSize: Size(250, 50),
                        ),
                        child: Text(
                          "Comment",
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Note*'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Please don\'t do religious hateful comment.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget desc_in_comment() {
    return Container(
      child: Card(
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                    child: CircleAvatar(
                      radius: 21,
                      backgroundColor: Colors.green,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(widget.photourl),
                      ),
                    ),
                  ),
                  Text(
                    widget.displayname,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  widget.desc,
                  style: GoogleFonts.dancingScript(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0),
                ),
              ),
            ],
          )),
    );
  }
}
