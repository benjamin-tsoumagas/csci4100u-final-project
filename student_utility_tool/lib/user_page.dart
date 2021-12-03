// @dart=2.9
// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_page.dart';
import 'global_content_holder.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key key}) : super(key: key);

  final String title = "Student's Utility Tool";

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List passwordList;
  bool isObscure = true;

  final users = FirebaseFirestore.instance.collection('user');

  Future<List> getData(String email) async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await users.where('email', isEqualTo: email).get();
    passwordList =
        querySnapshot.docs.map((doc) => doc.get('password')).toList();
    return passwordList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
            child: SizedBox(
              width: 370,
              height: 270,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 5, left: 20, right: 20),
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(labelText: "Email"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field cant be null';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 5, left: 20, right: 20),
                      child: TextFormField(
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
                            return 'This field cant be null';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        width: 350,
                        child: ElevatedButton.icon(
                            onPressed: () async {
                              if (formKey.currentState.validate()) {
                                passwordList =
                                    await getData(emailController.text);
                                if (passwordList != null &&
                                    passwordList[0] ==
                                        passwordController.text) {
                                  Navigator.pop(context);
                                  GlobalHolder.email = emailController.text;
                                  GlobalHolder.password =
                                      passwordController.text;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomePage(),
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Logged in successfully"),
                                    ),
                                  );
                                } else {
                                  _showErrorDialog(context);
                                }
                              }
                            },
                            icon: const Icon(Icons.login),
                            label: const Text("Login"))),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 30, left: 120),
            child: Row(
              children: [
                GestureDetector(
                  child: const Text(
                    "Create Account",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.purple,
                        decoration: TextDecoration.underline),
                  ),
                  onTap: () => _registerDialog(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showErrorDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Incorrect Credentials"),
          content: const Text(
              "You have entered wrong email address or password. Please try again."),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"))
          ],
        );
      },
    );
  }

  _registerDialog(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
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
                        height: height - 200,
                        width: width,
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
