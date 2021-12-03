// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'courses_page.dart';
import 'home_page.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          //Header containing Student *picture, name, and email
          const DrawerHeader(
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
          const ListTile(
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
          const ListTile(
            leading: Icon(Icons.calculate),
            title: Text("Grade Calculator"),
            trailing: Icon(Icons.chevron_right),
          ),
          //Option to go to Student Map
          const ListTile(
            leading: Icon(Icons.map),
            title: Text("Student Map"),
            trailing: Icon(Icons.chevron_right),
          ),
          //Option to go to Settings
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
          )
        ],
      ),
    );
  }
}
