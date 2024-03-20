import 'package:flutter/material.dart';
import 'maps.dart';
import 'settings_logout.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'MC LABS MAPS',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.settings), // Customize the icon based on your action
              onPressed: () {
                // Navigate to the desired screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              },
            ),
          ],
          backgroundColor: Colors.black,
        ),
        body: Maps());
  }
}
