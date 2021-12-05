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

  Future<List> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await userCourses.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  getCourseNamePopup(BuildContext context, String inputText) async {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    String actionText = 'Continue';
    if (inputText != null) {
      actionText = 'Update';
      nameController.text = inputText;
    }

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
                        height: size.height - 450,
                        width: size.width,
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                    labelText: "Course Name"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field cant be empty';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                  child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState.validate()) {
                                        Navigator.pop(
                                            context, nameController.text);
                                      }
                                    },
                                    child: Text(actionText)),
                              ))
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

  updateCoursePopup(BuildContext context, data) async {
    //get course name\\
    String courseName;
    List<GradePerAssesment> allAssigns = [];
    if (data == null) {
      courseName = await getCourseNamePopup(context, null);
      if (courseName == null) {
        return null;
      }
      allAssigns = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const CourseInputPage(),
      ));
    } else {
      courseName = await getCourseNamePopup(context, data['courseName']);
      if (courseName == null) {
        return null;
      }
      allAssigns = await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const CourseInputPage(),
          settings: RouteSettings(arguments: data['courseName'])));
    }

    // creating 3 lists of data for storing
    int size = allAssigns.length;
    var names = List.filled(size, "N/A");
    var weights = List.filled(size, 0.0);
    var grades = List.filled(size, 0.0);

    for (int i = 0; i < size; i++) {
      names[i] = allAssigns[i].name;
      weights[i] = allAssigns[i].weight;
      grades[i] = allAssigns[i].grade;
    }

    if (data != null && data['courseName'] != courseName) {
      userCourses.doc(data['courseName']).delete();
      setState(() {});
    }
    userCourses.doc(courseName).set({
      'courseName': courseName,
      'assignNames': names,
      'weights': weights,
      'grades': grades,
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Courses"),
        backgroundColor: Colors.purple,
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
                      double width = MediaQuery.of(context).size.width;

                      if (index == listSize) {
                        //last element is add new course button
                        return Container(
                          height: containerHeight,
                          color: colourStyle[
                              (index % 2) * colourDiff + colourShift],
                          child: Center(
                            child: ElevatedButton(
                                onPressed: () =>
                                    updateCoursePopup(context, null),
                                child: SizedBox(
                                    width: width * 0.25,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: width * 0.7,
                              child: Center(
                                child: Text(
                                  snapshot.data[index]['courseName'],
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                ),
                              ),
                            ),
                            SizedBox(
                                width: width * 0.15,
                                child: IconButton(
                                    onPressed: () => updateCoursePopup(
                                        context, snapshot.data[index]),
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.deepPurple,
                                    ))),
                            SizedBox(
                                width: width * 0.15,
                                child: IconButton(
                                    onPressed: () async {
                                      userCourses
                                          .doc(snapshot.data[index]
                                              ['courseName'])
                                          .delete();
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.deepPurple,
                                    )))
                          ],
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
  const CourseInputPage({Key key, this.courseName}) : super(key: key);
  final String courseName;

  @override
  State<StatefulWidget> createState() => CourseInputState();
}

class CourseInputState extends State<CourseInputPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextStyle textStyle =
      TextStyle(color: Colors.purple[400], fontSize: 16);
  final TextStyle textStyle2 =
      const TextStyle(color: Colors.white, fontSize: 16);
  List<GradePerAssesment> grades = [];

  gradesInputPopup(GradePerAssesment data) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController assessmentTypeController = TextEditingController();
    TextEditingController weightController = TextEditingController();
    TextEditingController gradeController = TextEditingController();
    String actionText = 'Add Grade';
    String otherActionText = 'Cancel';
    if (data != null) {
      assessmentTypeController.text = data.name;
      weightController.text = data.weight.toString();
      gradeController.text = data.grade.toString();
      actionText = 'Update Grade';
      otherActionText = 'Delete';
    }

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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (data != null) {
                                            grades.remove(data);
                                            Navigator.pop(context);
                                          } else {
                                            Navigator.pop(context, data);
                                          }
                                        },
                                        child: Text(otherActionText)),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (formKey.currentState.validate()) {
                                            data ??= GradePerAssesment();
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
    double width = MediaQuery.of(context).size.width;

    /*for (int i; i < data['assignNames'].length; i++) {
      GradePerAssesment newGrade = GradePerAssesment();
      newGrade.name = data['assignNames'][i];
      newGrade.weight = double.parse(data['weights'][i]);
      newGrade.grade = double.parse(data['grades'][i]);
      allAssigns.add(GradePerAssesment());
    }*/

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Grades"),
          backgroundColor: Colors.purple,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context, grades);
                },
                icon: const Icon(Icons.save))
          ],
        ),
        body: ListView.builder(
            itemCount: grades.length + 2,
            itemBuilder: (BuildContext context, int index) {
              //settings\\
              double containerHeight = 60;
              MaterialColor colourStyle = Colors.purple;
              int colourDiff = 50;
              int colourShift = 50;

              if (index == 0) {
                return Container(
                  height: containerHeight,
                  color: Colors.purple[300],
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.4,
                        child: Center(
                          child: Text(
                            'Assesment Type',
                            style: textStyle2,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.2,
                        child: Center(
                          child: Text(
                            'Weight',
                            style: textStyle2,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.2,
                        child: Center(
                          child: Text(
                            'Grade',
                            style: textStyle2,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (index == grades.length + 1) {
                //last element is add new grade button
                return Container(
                  height: containerHeight,
                  color:
                      colourStyle[(index - 1 % 2) * colourDiff + colourShift],
                  child: Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          var newGradeData = await gradesInputPopup(null);
                          if (newGradeData != null) {
                            grades.add(newGradeData);
                            setState(() {});
                          }
                        },
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
                color: colourStyle[(index - 1 % 2) * colourDiff + colourShift],
                child: Center(
                  child: Row(
                    children: [
                      SizedBox(
                          width: width * 0.4,
                          child: Center(
                            child: Text(
                              grades[index - 1].name,
                              style: textStyle,
                            ),
                          )),
                      SizedBox(
                        width: width * 0.2,
                        child: Center(
                          child: Text(
                            grades[index - 1].weight.toString() + '%',
                            style: textStyle,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.2,
                        child: Center(
                          child: Text(
                            grades[index - 1].grade.toString() + '%',
                            style: textStyle,
                          ),
                        ),
                      ),
                      SizedBox(
                          width: width * 0.2,
                          child: Center(
                            child: IconButton(
                              onPressed: () async {
                                var newGradeData =
                                    gradesInputPopup(grades[index - 1]);
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ))
                    ],
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

  @override
  String toString() {
    return name +
        'weighs' +
        weight.toString() +
        '% and got a ' +
        grade.toString() +
        '% as a grade';
  }
}
