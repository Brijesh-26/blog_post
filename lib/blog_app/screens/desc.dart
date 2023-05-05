import 'package:blog_post/blog_app/screens/blog_home.dart';
import 'package:blog_post/blog_app/screens/new_post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
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
  final user = FirebaseAuth.instance.currentUser!;
  TextEditingController comment = TextEditingController();

  final databaseRef = FirebaseDatabase.instance.ref('Comment');

  var map = {
    '1': 'Jan',
    '2': 'Feb',
    '3': 'Mar',
    '4': 'Apr',
    '5': 'May',
    '6': 'Jun',
    '7': 'July',
    '8': 'Aug',
    '9': 'Sep',
    '10': 'Oct',
    '11': 'Nov',
    '12': 'Dec'
  };

  int flag = 0;

  // final dbref = FirebaseDatabase.instance.ref('Comment').child(widget.postId);

  submitCommentToDb(String comment) {
    DateTime nowDate = DateTime.now();
    int currMonth = nowDate.month;
    int currDay = nowDate.day;

    databaseRef
        .child(widget.postId)
        .child(DateTime.now().millisecondsSinceEpoch.toString())
        .set({
      'comment': comment,
      'author_name': user.displayName,
      'author_photo': user.photoURL,
      'month': currMonth,
      'day': currDay,
    }).then((value) {
      Fluttertoast.showToast(msg: 'comment added successfully');

      Navigator.pop(context);
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(
          msg:
              'issues regarding posting blog!!! Please check internet connection');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   CupertinoPageRoute(builder: (context) => MyHomePage()),
                // );

                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back)),
          backgroundColor: Color.fromARGB(255, 180, 178, 178),
          title: Text(
            'Comments',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          desc_in_comment(),

          Padding(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
              child: Text(
                'Comments-',
                style: GoogleFonts.roboto(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              )),

          // fetch comment from firebase using post id(in realtime database)

          Expanded(
              child: FirebaseAnimatedList(
                  physics: BouncingScrollPhysics(),
                  query: databaseRef.child(widget.postId),
                  itemBuilder: ((context, snapshot, animation, index) {
                    return commentCard(
                        context,
                        snapshot.child('author_name').value.toString(),
                        snapshot.child('author_photo').value.toString(),
                        snapshot.child('day').value.toString(),
                        snapshot.child('month').value.toString(),
                        snapshot.child('comment').value.toString());
                  }))),

          // commentCard()
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromARGB(153, 255, 252, 252),
        foregroundColor: Color.fromARGB(115, 0, 0, 0),
        onPressed: () {
          popDialog();
        },
        label: Text('add comment'),
        icon: Icon(Icons.comment),
      ),
    );
  }

  // in comment card we've got commentator_image, commentator_author, comment_date, comment

  // THIS WILL GET DISPLAYED BELOW THE COMMENT SECTION
  commentCard(BuildContext context, String comment_author, String comment_photo,
      String day, String month, String comment) {
    return Container(
      child: Card(
          // elevation: 5.0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color.fromARGB(248, 255, 255, 255)),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                        child: CircleAvatar(
                          radius: 21,
                          backgroundColor: Colors.green,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(comment_photo),
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comment_author,
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                "commented on  $day  ${map[month]}",
                                style: TextStyle(fontSize: 8.0),
                              ),
                            ]),
                      )
                    ]),
                  ),

                  // here we can take an action on any comment if this is hateful or hurting religious sentiment

                  // there will be two cases--- 1--> admin commented
                  //                                a--> edit
                  //                                b--> delete
                  //                            2--> user commented
                  //                                a--> report

                  // it means admin is commenting

                  // if(comment_author==widget.displayname){

                  // }
                  // // other user is commenting
                  // else{

                  // }Icon(Icons.more_vert)

                  Container(
                    child: Icon(Icons.more_vert),
                  )
                ],
              ),
              Divider(
                thickness: 2.0,
                indent: 5.0,
                endIndent: 10.0,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 5.0, 5.0, 5.0),
                child: Text(
                  comment,
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

  // THIS IS FOR COMMENTING FOR A SPECIFIC POST
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

  // THIS IS FOR SHOWING POST DESCRIPTION IN COMMENT SECTION
  Widget desc_in_comment() {
    return Container(
      child: Card(
          elevation: 3.0,
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
