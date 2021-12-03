// @dart=2.9
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'navigation_drawer.dart';
import 'global_content_holder.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key key}) : super(key: key);

  final String email = "Student's Utility Tool";
  final String userName = "";
  final String password = "";

  @override
  State<CoursesPage> createState() => _CourseListState();
}

class _CourseListState extends State<CoursesPage> {
  ListView getBodyContent() {
    // get listview items from firebbase if new data then create new data \\
    int listSize = 3;
    double containerHeight = 60;

    //settings\\
    MaterialColor colourStyle = Colors.purple;
    int colourDiff = 50;
    int colourShift = 50;

    return ListView.builder(
        itemCount: listSize + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == listSize) {
            //last element is add new course button
            return Container(
              height: containerHeight,
              color: colourStyle[(index % 2) * colourDiff + colourShift],
              child: Center(
                child: ElevatedButton(
                    onPressed: () {
                      // Bring to new course popup \\
                    },
                    child: SizedBox(
                        width: 100,
                        child: Row(children: const [
                          Icon(Icons.add),
                          Text('Add Course')
                        ]))),
              ),
            );
          }
          return Container(
            height: containerHeight,
            color: colourStyle[(index % 2) * colourDiff + colourShift],
            child: Center(
              child: GestureDetector(
                  onTap: () {
                    // Bring to the course data page \\
                  },
                  child: const Text('Testing') // course name \\
                  ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Courses"),
      ),
      drawer: const NavigationDrawerWidget(),
      body: getBodyContent(),
    );
  }
}
