import 'package:blog_post/blog_app/auth/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Spacer(),
            // FlutterLogo(
            //   size: 120,
            // ),

            Icon(Icons.person_2_outlined, color: Colors.blueAccent, size: 120,),
            Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Hey Visitor,\nWelcome Back',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  minimumSize: Size(double.infinity, 50)),
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);

                provider.googleLogin();
              },
              icon: FaIcon(
                FontAwesomeIcons.google,
                color: Colors.red,
              ),
              label: Text('Sign In With Google'),
            ),

            Spacer()
          ]),
        )));
  }
}
