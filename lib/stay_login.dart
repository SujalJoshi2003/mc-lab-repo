import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'home_screen.dart';

class StayLogIn extends StatefulWidget {
  @override
  _StayLogInState createState() => _StayLogInState();
}

class _StayLogInState extends State<StayLogIn> {
  Future<User?> checkLoginStatus() async {
    return FirebaseAuth.instance.authStateChanges().first;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // If the Future is still running, show a loading indicator
          return CircularProgressIndicator();
        } else {
          // If the Future is completed
          if (snapshot.hasError) {
            // If there is an error, handle it accordingly
            return Text('Error: ${snapshot.error}');
          } else {
            // Check if the user is signed in or out
            if (snapshot.data != null) {
              // User is signed in
              return HomeScreen();
            } else {
              // User is signed out
              return JustLogin();
            }
          }
        }
      },
    );
  }
}