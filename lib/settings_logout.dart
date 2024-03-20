import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "custom_navigation.dart";
import 'login_page.dart';
import 'package:elegant_notification/elegant_notification.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<void> showNotifications() async {
    ElegantNotification.success(
        width: MediaQuery.of(context).size.width,
        toastDuration: Duration(seconds: 3000),
        title: Text("Twitter Clone"),
        description: Text("This is a notification from Sujal"))
        .show(context);
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    navigateWithFadeTransition(context, JustLogin());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "Logged-out",
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 150,
            ),
            Column(children: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(onPressed: logout, child: Text("Log out")),
              ]),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                    onPressed: showNotifications,
                    child: Text("Send notification")),
              ]),
            ]),
          ],
        ),
      ),
    );
  }
}