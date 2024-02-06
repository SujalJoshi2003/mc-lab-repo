import "package:flutter/material.dart";
import 'package:learning_flutter/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learning_flutter/home_screen.dart';
import 'package:elegant_notification/elegant_notification.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );

      // Navigate to the home screen after successful sign-in
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false,
      );

      ElegantNotification.success(
              width: MediaQuery.of(context).size.width,
              toastDuration: Duration(seconds: 3000),
              title: Text("Twitter Clone"),
              description: Text("You have succesfully signed-in!"))
          .show(context);
    } catch (e) {
      final errorMessage = "An error occurred: $e";

      final snackBarMessage = errorMessage.length > 50
          ? "An error occurred. Please check the details."
          : errorMessage;
      ElegantNotification.success(
              width: MediaQuery.of(context).size.width,
              toastDuration: Duration(seconds: 3000),
              title: Text("Twitter Clone"),
              description: Text(snackBarMessage))
          .show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 75,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Sign in to your Account",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    controller: _email,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    obscureText: true,
                    controller: _password,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: signIn,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    child:
                        Text('Sign-in', style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => ForgotPassword()),
                    // );
                  },
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Don't have an account",
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child:
                        Text("Sign Up", style: TextStyle(color: Colors.black)))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
