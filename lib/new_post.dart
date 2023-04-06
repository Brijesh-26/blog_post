import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  TextEditingController title = TextEditingController();

  TextEditingController desc = TextEditingController();

  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();
  // Pick an image.

  File? _image;

  Future getImage() async {
    print('clicked for picking image');
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    print('image picked');

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('no image selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 227, 227),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 20.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  NeumorphicIcon(
                    Icons.add,
                    size: 30,
                  ),
                  NeumorphicText(
                    "New Post",
                    style: NeumorphicStyle(
                      surfaceIntensity: 1,
                      depth: 8, //customize depth here
                      color: Colors.white, //customize color here
                    ),
                    textStyle: NeumorphicTextStyle(
                      fontSize: 25, //customize size here
                      // AND others usual text style properties (fontFamily, fontWeight, ...)
                    ),
                  ),
                ]),
              ),

              // giving space for image

              Padding(
                padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 20.0),
                child: _image == null
                    ? NeumorphicButton(
                      onPressed: getImage,
                      style: NeumorphicStyle(
                          shape: NeumorphicShape.convex,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(10)),
                          depth: 10,
                          intensity: .85,
                          surfaceIntensity: .8,
                          lightSource: LightSource.topLeft,
                          color: Color.fromARGB(255, 247, 198, 198)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_photo_alternate, size: 20),
                          Text('Add Image',
                              style: GoogleFonts.dancingScript(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0))
                        ],
                      ),
                    )
                    : Container(
                        height: MediaQuery.of(context).size.height * .30,
                        width: MediaQuery.of(context).size.width * .50,
                        child: Image(
                          image: FileImage(_image!),
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                          height: MediaQuery.of(context).size.height * .30,
                          width: MediaQuery.of(context).size.width * .50,
                        )),
              ),

              // giving title
              Padding(
                padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
                child: Container(
                  child: TextField(
                    controller: title,
                    style: GoogleFonts.dancingScript(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Give a Title',
                    ),
                  ),
                ),
              ),

              // giving desc

              Padding(
                padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 20.0),
                child: Container(
                  child: TextField(
                    controller: desc,
                    style: GoogleFonts.dancingScript(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0),
                    maxLines: 7,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Give The Description',
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 20.0),
                child: NeumorphicButton(
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.convex,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(10)),
                        depth: 10,
                        intensity: .85,
                        surfaceIntensity: .8,
                        lightSource: LightSource.bottom,
                        color: Color.fromARGB(255, 132, 246, 128)),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .60,
                      child: _isLoading
                          ? Text('Sharing.........',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dancingScript(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0))
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.done, size: 20),
                                Text('Share with Community',
                                    style: GoogleFonts.dancingScript(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.0))
                              ],
                            ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
