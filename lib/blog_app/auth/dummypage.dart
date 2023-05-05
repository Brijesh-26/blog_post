import 'package:blog_post/blog_app/screens/blog_home.dart';
import 'package:blog_post/blog_app/auth/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DummyPage extends StatelessWidget {
  const DummyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('something went wrong'),
              );
            } else if (snapshot.hasData) {
              return MyHomePage();
            } else
              return Splash();
          }),
    );
  }
}
