// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'courses_page.dart';
import 'home_page.dart';
import 'map_page.dart';
import 'grade_page.dart';

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
                builder: (context) => const HomePage(),
              ));
            },
          ),
          //Option to go to Add Grades
          ListTile(
            leading: const Icon(Icons.insert_chart),
            title: const Text("Add Grade"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
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
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GradeCalculatorPage()));
            },
          ),
          //Option to go to Student Map
          ListTile(
            leading: const Icon(Icons.map),
            title: const Text("Student Map"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MapPage(),
              ));
            },
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
