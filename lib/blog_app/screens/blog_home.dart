import 'dart:io';
import 'dart:typed_data';

import 'package:blog_post/blog_app/settings/Liked.dart';
import 'package:blog_post/blog_app/screens/blogs_model.dart';
import 'package:blog_post/blog_app/screens/desc.dart';
import 'package:blog_post/blog_app/screens/new_post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:blog_post/blog_app/screens/category.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  bool isOn = false;
  bool like = false;

  final ref = FirebaseDatabase.instance.ref('Post');

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

  var lsmap = {
    'Entertainment':
        'https://tse2.mm.bing.net/th?id=OIP.KaLaojhfeneRN0g-gWGQogHaEk&pid=Api&P=0',
    'Religious':
        'https://tse1.mm.bing.net/th?id=OIP.-xCgYqfCQDEl3YmlGVKS2gHaE3&pid=Api&P=0',
    'Human Rights':
        'https://tse3.mm.bing.net/th?id=OIP.4I5CMhtlHZZxcPZtgJQ7FwHaEg&pid=Api&P=0',
    'Foreign Affairs':
        'https://tse4.mm.bing.net/th?id=OIP.WTP4pj0-rXaI4_hJsJG-0wHaEX&pid=Api&P=0',

    'Zym Motivation': 'https://tse1.mm.bing.net/th?id=OIP.pwyM78BM7F5VPh-4EXU-pwAAAA&pid=Api&P=0',

    'Fashion': 'https://tse4.mm.bing.net/th?id=OIP.vHSvlTiSA7s7CquYTITBigHaD6&pid=Api&P=0'
  };

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

              Container(
                height: 80,
                // padding: EdgeInsets.symmetric(horizontal: 24),
                child: ListView.builder(
                  itemCount: 6,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final key = lsmap.keys.elementAt(index);
                    final value = lsmap[key];

                    return CategoriesTile(title: key, imgUrl: value!);
                  },
                ),
              ),

              Expanded(
                  child: FirebaseAnimatedList(
                      physics: BouncingScrollPhysics(),
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
                            snapshot.child('postId').value.toString());
                      }))),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromARGB(153, 255, 252, 252),
        foregroundColor: Color.fromARGB(115, 0, 0, 0),
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

  Widget CustomCard(
      BuildContext context,
      String titlecard,
      String descCard,
      String path,
      String author,
      String photoUrl,
      String day,
      String month,
      String postId) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // fetching image from google photo
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

                          // fetching google username
                          Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    author,
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                  Text(
                                    "posted on   $day${map[month]}",
                                    style: TextStyle(fontSize: 8.0),
                                  ),
                                ]),
                          )
                        ]),
                  )),
              Divider(
                thickness: 2.0,
                height: 15.0,
              ),
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
                // applying like option on post
                onDoubleTap: () {
                  print('double clicked on this post');

                  // TODO:  here write a function to submit no of like on this post in firebase realtime database
                },
                child: Container(
                  child: Column(children: [
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
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0),
                      ),
                    ),
                  ]),
                ),
              ),
            ]),
          ),
          Divider(
            thickness: 2.0,
            height: 15.0,
          ),
          Container(
            child: Row(children: [
              Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              Text(' Liked by  '),
              GestureDetector(
                  onTap: () {
                    // going to liked page
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => Liked(
                              photourl: photoUrl,
                              displayname: author,
                              postId: postId)),
                    );
                  },
                  child: Text(
                    'Brijesh kumar verma',
                    style: TextStyle(fontSize: 10.0),
                  ))
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
