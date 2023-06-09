import 'package:blog_post/blog_app/screens/blogs_model.dart';
import 'package:blog_post/blog_app/screens/desc.dart';
import 'package:blog_post/blog_app/auth/google_sign_in.dart';
import 'package:blog_post/blog_app/screens/new_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'blog_app/auth/dummypage.dart';
import 'blog_app/screens/blog_home.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(


    create: ((context) => GoogleSignInProvider()),
    child: NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        baseColor: Color(0xFFFFFFFF),
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: Color(0xFF3E3E3E),
        lightSource: LightSource.topLeft,
        depth: 6,
      ),
      home: DummyPage(),
    ),
  );
}

//  home: MyAppClient().getCurrentUser() != null
//       ? HomeViewController()
//       : LoginViewController(),