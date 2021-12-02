// @dart=2.9
// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:student_utility_tool/home.dart';

class StreamBuilderWidget extends StatefulWidget {
  const StreamBuilderWidget({Key key}) : super(key: key);

  @override
  _StreamBuilderWidgetState createState() => _StreamBuilderWidgetState();
}

class _StreamBuilderWidgetState extends State<StreamBuilderWidget> {
  final users = FirebaseFirestore.instance.collection('user');
  int selectedIndex = -1;
  var documentID;
  String password = '';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //Error handling for if there are no users entered
        if (!snapshot.hasData) {
          return const Center(
            child: Text("No Users"),
          );
        }
        return Card(
            child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: ListTile(
                      selected: false,
                      tileColor: selectedIndex == index ? Colors.blue : null,
                      title: Text(snapshot.data.docs[index]['username']),
                      subtitle: Text(snapshot.data.docs[index]['email']),
                      trailing: IconButton(
                          onPressed: () {
                            setState(
                              () {
                                _showAlertDialog(context);
                              },
                            );
                          },
                          icon: const Icon(Icons.delete)),
                      onTap: () {
                        setState(
                          () {
                            if (selectedIndex == index) {
                              password = snapshot.data.docs[index]['password'];
                              _customDialog();
                            }
                            selectedIndex = index;
                            documentID = snapshot.data.docs[index].id;
                          },
                        );
                      },
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => Divider(
                      height: 5,
                      color: Colors.grey.shade200,
                    ),
                itemCount: snapshot.data.docs.length));
      },
    );
  }

  _showAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Warning"),
          content: const Text("Are you sure you want to delete this user?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context, "Yes");
                },
                child: const Text("Yes")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context, "No");
                },
                child: const Text("No"))
          ],
        );
      },
    ).then(
      (value) {
        if (value == "Yes") {
          final users = FirebaseFirestore.instance.collection('user');
          users.doc(documentID).delete();
        }
      },
    );
  }

  _customDialog() {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController passwordController = TextEditingController();
    bool isObscure = true;

    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Builder(
                builder: (BuildContext context) {
                  var height = MediaQuery.of(context).size.height;
                  var width = MediaQuery.of(context).size.width;

                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(),
                      child: SizedBox(
                        height: height - 70,
                        width: width,
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 30),
                              TextFormField(
                                obscureText: isObscure,
                                controller: passwordController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r"\s"),
                                  )
                                ],
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
                                  if (value == null ||
                                      value.isEmpty ||
                                      value != password) {
                                    return 'Incorrect password';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 50),
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState.validate()) {
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage(),
                                          ),
                                        );
                                      }
                                    },
                                    child: const Text("Log in")),
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
}
