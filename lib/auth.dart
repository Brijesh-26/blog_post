import 'package:blog_post/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

enum AuthStatus { LoggedIn, NotLoggedIn, NotDetermined }

class _AuthState extends State<Auth> {
  AuthStatus _authStatus = AuthStatus.NotDetermined;
  FirebaseAuth auth = FirebaseAuth.instance;
  Future _checkAuthStatus() async {
    User? currentUser = auth.currentUser;

    if (currentUser == null) {
      setState(() {
        _authStatus = AuthStatus.NotLoggedIn;
      });

      registerUser();
    } else {
      _authStatus = AuthStatus.LoggedIn;
    }
  }

  Future registerUser() async {
    auth.signInAnonymously().then((value) {
      if (value != null) {
        setState(() {
          _authStatus = AuthStatus.LoggedIn;
        });

        print('regitration completed');
        print('going to home page..........');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );

        print('welcome to home page');
      } else {
        print('registration failed');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkAuthStatus();
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.LoggedIn:
        return MyHomePage();
        break;

      case AuthStatus.NotLoggedIn:
        return SplashScreen();
        break;

      case AuthStatus.NotDetermined:
        return SplashScreen();
        break;

      default:
        return SplashScreen();
    }
  }
}

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          //TODO: fetch function from one class to this class
        },
        child: Text('click to register anonymously'),
      )),
    );
  }
}
