// @dart=2.9

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  final String title = "Student's Utility Tool";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: Column(
          children: const [
            //Header containing Student *picture, name, and email
            DrawerHeader(
              child: Text("Drawer Header"),
            ),
            //Option to go to Home
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              trailing: Icon(Icons.chevron_right),
            ),
            //Option to go to Add Grades
            ListTile(
              leading: Icon(Icons.insert_chart),
              title: Text("Add Grade"),
              trailing: Icon(Icons.chevron_right),
            ),
            //Option to go to Courses
            ListTile(
              leading: Icon(Icons.portrait),
              title: Text("My Courses"),
              trailing: Icon(Icons.chevron_right),
            ),
            //Option to go to Grade Calculator
            ListTile(
              leading: Icon(Icons.calculate),
              title: Text("Grade Calculator"),
              trailing: Icon(Icons.chevron_right),
            ),
            //Option to go to Student Map
            ListTile(
              leading: Icon(Icons.map),
              title: Text("Student Map"),
              trailing: Icon(Icons.chevron_right),
            ),
            //Option to go to Settings
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
            )
          ],
        ),
      ),
      //Yet to be implemented
      body: Column(),
    );
  }
}
