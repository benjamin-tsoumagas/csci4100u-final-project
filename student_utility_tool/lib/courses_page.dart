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

  /*ListView getBodyContent(var dataList) {
    // get listview items from firebbase if new data then create new data \\
    int listSize = dataList.length;

    //settings\\
    double containerHeight = 60;
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
  }*/

  /*_showNewCourseDialog(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    bool isObscure = true;

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                content: Builder(
                  builder: (BuildContext context) {
                    var size = MediaQuery.of(context).size;

                    return SingleChildScrollView(
                      child: SizedBox(
                        height: size.height - 150,
                        width: size.width,
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                controller: usernameController,
                                decoration: const InputDecoration(
                                    labelText: "Username"),
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
                                controller: emailController,
                                decoration:
                                    const InputDecoration(labelText: "Email"),
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
                                obscureText: isObscure,
                                controller: passwordController,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(
                                        () {
                                          isObscure = !isObscure;
                                        },
                                      );
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field cant be empty';
                                  }
                                  if (value.length < 6) {
                                    return 'Password too short';
                                  }
                                  return null;
                                },
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30),
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState.validate()) {
                                        final users = FirebaseFirestore.instance
                                            .collection('user');
                                        users.add(
                                          {
                                            'username': usernameController.text,
                                            'email': emailController.text,
                                            'password': passwordController.text,
                                          },
                                        );
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: const Text("Create Account")),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        });
  }*/

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
