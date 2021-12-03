// @dart=2.9
import 'package:flutter/material.dart';
import 'package:student_utility_tool/navigation_drawer.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key key}) : super(key: key);

  final String title = "Student's Utility Tool";

  @override
  State<CoursesPage> createState() => _CourseListState();
}

class _CourseListState extends State<CoursesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Courses"),
      ),
      drawer: NavigationDrawerWidget(),
    );
  }
}
