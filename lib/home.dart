import 'dart:io';
import 'dart:typed_data';

import 'package:blog_post/blogs_model.dart';
import 'package:blog_post/desc.dart';
import 'package:blog_post/new_post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  bool isOn = false;
  bool like = false;

  final ref = FirebaseDatabase.instance.ref('Post');

  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "July",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
          child: Column(
            children: [
              // this part describe appbar in home page
              Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          child: Text('Blogger',
                              style: GoogleFonts.dancingScript(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold))),
                      Container(
                          child: NeumorphicButton(
                              margin: EdgeInsets.only(top: 12),
                              onPressed: () {
                                NeumorphicTheme.of(context)?.themeMode =
                                    NeumorphicTheme.isUsingDark(context)
                                        ? ThemeMode.light
                                        : ThemeMode.dark;
                              },
                              style: NeumorphicStyle(
                                shape: NeumorphicShape.flat,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(8)),
                              ),
                              padding: const EdgeInsets.all(12.0),
                              child: Icon(Icons.light))),
                    ]),
              ),

              // TODO: now create body part

              SizedBox(
                height: 20.0,
              ),

              Expanded(
                  child: FirebaseAnimatedList(
                      query: ref,
                      itemBuilder: ((context, snapshot, animation, index) {
                        return CustomCard(
                            context,
                            snapshot.child('title').value.toString(),
                            snapshot.child('description').value.toString(),
                            snapshot.child('image').value.toString(),
                            snapshot.child('author').value.toString(),
                            snapshot.child('photoUrl').value.toString(),
                            snapshot.child('day').value.toString(),
                            snapshot.child('month').value.toString(),
                            snapshot.child('postId').toString()
                            
                            );
                      }))),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromARGB(135, 83, 230, 249),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
                fullscreenDialog: true, builder: (context) => Post()),
          );
        },
        label: Text('New Post'),
        icon: Icon(Icons.add),
      ),
    );
  }

  Widget CustomCard(BuildContext context, String titlecard, String descCard,
      String path, String author, String photoUrl, String day, String month, String postId) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => Desc(
                          desc: descCard,

                          photourl: photoUrl,
                          displayname: author,

                          postId: postId,
                        )),
              );
            },
            child: Container(
              child: Column(children: [
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: 22,
                              child: CircleAvatar(
                                  radius: 20,
                                  foregroundColor: Colors.black,
                                  backgroundImage: NetworkImage(photoUrl)),
                            ),
                            // in googlecircularavatar
                            SizedBox(
                              width: 8.0,
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                Text(
                                  author,
                                  style: TextStyle(fontSize: 12.0),
                                ),
                                Text(
                                  "posted on   "+day,
                                  style: TextStyle(fontSize: 9.0),

                                ),
                              ]),
                            )
                          ]),
                    )),
                Divider(
                  thickness: 2.0,
                  height: 15.0,
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    titlecard,
                    style: GoogleFonts.dancingScript(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                      'https://tse4.mm.bing.net/th?id=OIP.rvSWtRd_oPRTwDoTCmkP5gHaE8&pid=Api&P=0'),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    descCard,
                    style: GoogleFonts.dancingScript(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0),
                  ),
                ),
              ]),
            ),
          ),
          Divider(
            thickness: 2.0,
            height: 15.0,
          ),
          Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    like ? Icons.favorite : Icons.favorite_border_outlined,
                    color: Colors.red,
                  ),
                  Icon(
                    Icons.comment_outlined,
                  ),
                  Icon(Icons.send)
                ]),
          ),
          SizedBox(
            height: 10.0,
          )
        ],
      ),
    );
  }
}
