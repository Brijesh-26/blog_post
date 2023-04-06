import 'package:blog_post/blogs_model.dart';
import 'package:blog_post/desc.dart';
import 'package:blog_post/new_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';


class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isOn = false;
  bool like = false;

  // Future<List<Blogs>> _getData() async {
  //   List<Blogs> blogData = [];

    
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _getData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
          child: Column(
            children: [
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
              // this is a model item

              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: ((context, index) {
                    return CustomCard(context);
                  }),
                ),
              ),
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

  Widget CustomCard(BuildContext context) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          GestureDetector(
            onDoubleTap: () {
              // apply instagram like animation
              // search this on instagram
              setState(() {
                like = true;
              });
              print('double tap');
            },
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Desc()),
              );
            },
            child: Container(
              child: Column(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                      'https://tse4.mm.bing.net/th?id=OIP.IIMoYouKRYtMO8_YM36T2wHaEK&pid=Api&P=0'),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    'Ananya is my ankit\'s love  but disha will give their ass to brijesh................',
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
