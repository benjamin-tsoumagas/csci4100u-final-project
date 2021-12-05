// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:student_utility_tool/user_page.dart';
import 'courses_page.dart';
import 'edit_profile_page.dart';
import 'home_page.dart';
import 'map_page.dart';
import 'grade_calculator_page.dart';
import 'global_content_holder.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          //Header containing Student *picture, name, and email
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    'https://www.seekpng.com/png/detail/41-410093_circled-user-icon-user-profile-icon-png.png',
                  ),
                ),
                Text(GlobalHolder.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
                Text(
                  GlobalHolder.email,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          //Option to go to Home
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          ),
          //Option to go to Courses
          ListTile(
            leading: const Icon(Icons.portrait),
            title: const Text("My Courses"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CoursesPage(),
                ),
              );
            },
          ),
          //Option to go to Grade Calculator
          ListTile(
            leading: const Icon(Icons.calculate),
            title: const Text("Grade Calculator"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => GradeCalculatorPage(),
                ),
              );
            },
          ),
          //Option to go to Student Map
          ListTile(
            leading: const Icon(Icons.map),
            title: const Text("Student Map"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MapPage(),
                ),
              );
            },
          ),
          //Option to go to Settings
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Edit Profile"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const EditProfilePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Log Out"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const UserPage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
