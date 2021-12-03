import 'package:flutter/material.dart';
import 'courses_page.dart';
import 'home_page.dart';

class NavigationDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          //Header containing Student *picture, name, and email
          DrawerHeader(
            child: Text("Drawer Header"),
          ),
          //Option to go to Home
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomePage(),
              ));
            },
          ),
          //Option to go to Add Grades
          ListTile(
            leading: Icon(Icons.insert_chart),
            title: Text("Add Grade"),
            trailing: Icon(Icons.chevron_right),
          ),
          //Option to go to Courses
          ListTile(
            leading: const Icon(Icons.portrait),
            title: const Text("My Courses"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CoursesPage(),
              ));
            },
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
    );
  }
}
