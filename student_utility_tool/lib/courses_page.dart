// @dart=2.9
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'navigation_drawer.dart';
import 'global_content_holder.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key key}) : super(key: key);

  @override
  State<CoursesPage> createState() => _CourseListState();
}

class _CourseListState extends State<CoursesPage> {
  //Varaible Declarations\\
  final userCourses = FirebaseFirestore.instance
      .collection('user')
      .doc(GlobalHolder.email)
      .collection('Courses');
  Future<List> _userCourses;

  @override
  void initState() {
    super.initState();
    _userCourses = getData();
  }

  Future<List> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await userCourses.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  newCoursePopup(BuildContext context) {
    // get new line of data
    final grades = Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CourseInputPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Courses"),
      ),
      drawer: const NavigationDrawerWidget(),
      body: FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot) {
            //settings\\
            double containerHeight = 60;
            MaterialColor colourStyle = Colors.purple;
            int colourDiff = 50;
            int colourShift = 50;

            int listSize = snapshot.data.length;

            return snapshot.hasData
                ? ListView.builder(
                    itemCount: listSize + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == listSize) {
                        //last element is add new course button
                        return Container(
                          height: containerHeight,
                          color: colourStyle[
                              (index % 2) * colourDiff + colourShift],
                          child: Center(
                            child: ElevatedButton(
                                onPressed: () => newCoursePopup(context),
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
                        color:
                            colourStyle[(index % 2) * colourDiff + colourShift],
                        child: Center(
                          child: GestureDetector(
                              onTap: () {
                                // Bring to the course data page \\
                              },
                              child: const Text('Testing') // course name \\
                              ),
                        ),
                      );
                    })
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////

class CourseInputPage extends StatefulWidget {
  const CourseInputPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CourseInputState();
}

class CourseInputState extends State<CourseInputPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<GradePerAssesment> grades = [];

  gradesInputPopup(GradePerAssesment data) {
    // most of the code taken from user_page.dart\
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController assessmentTypeController = TextEditingController();
    TextEditingController weightController = TextEditingController();
    TextEditingController gradeController = TextEditingController();
    String actionText = 'Add Grade';
    if (data != null) {
      assessmentTypeController.text = data.name;
      weightController.text = data.weight.toString();
      gradeController.text = data.grade.toString();
      actionText = 'Update Grade';
    } else {
      data = GradePerAssesment();
    }
    bool isObscure = true;

    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Builder(
                builder: (BuildContext context) {
                  var size = MediaQuery.of(context).size;

                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(),
                      child: SizedBox(
                        height: size.height - 200,
                        width: size.width,
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                controller: assessmentTypeController,
                                decoration: const InputDecoration(
                                    labelText: "Assesment Type"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field cant be empty';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: weightController,
                                decoration: const InputDecoration(
                                    labelText: "Weight (%)"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field cant be empty';
                                  }
                                  try {
                                    double temp = double.parse(value);
                                    if (temp < 0 || temp > 100) {
                                      return 'This is an invalid number';
                                    }
                                  } on FormatException {
                                    return 'This is not a number';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                obscureText: isObscure,
                                controller: gradeController,
                                decoration: const InputDecoration(
                                  labelText: "Grade (%)",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field cant be empty';
                                  }
                                  try {
                                    double temp = double.parse(value);
                                    if (temp < 0 || temp > 100) {
                                      return 'This is an invalid number';
                                    }
                                  } on FormatException {
                                    return 'This is not a number';
                                  }
                                  return null;
                                },
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (formKey.currentState.validate()) {
                                            Navigator.pop(context, data);
                                          }
                                        },
                                        child: const Text("Cancel")),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (formKey.currentState.validate()) {
                                            data.name =
                                                assessmentTypeController.text;
                                            data.weight = double.parse(
                                                weightController.text);
                                            data.grade = double.parse(
                                                gradeController.text);
                                            Navigator.pop(context, data);
                                          }
                                        },
                                        child: Text(actionText)),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Grades"),
        ),
        body: ListView.builder(
            itemCount: grades.length + 1,
            itemBuilder: (BuildContext context, int index) {
              //settings\\
              double containerHeight = 60;
              MaterialColor colourStyle = Colors.purple;
              int colourDiff = 50;
              int colourShift = 50;

              if (index == grades.length) {
                //last element is add new course button
                return Container(
                  height: containerHeight,
                  color: colourStyle[(index % 2) * colourDiff + colourShift],
                  child: Center(
                    child: ElevatedButton(
                        onPressed: () => gradesInputPopup(null),
                        child: SizedBox(
                            width: 150,
                            child: Row(children: const [
                              Icon(Icons.add),
                              Text('Add Assesment')
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
            }));
  }
}

class GradePerAssesment {
  String name;
  double weight;
  double grade;
}
