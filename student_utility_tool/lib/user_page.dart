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
  List usernameList;
  bool isObscure = true;

  final users = FirebaseFirestore.instance.collection('user');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        backgroundColor: Colors.purple,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 5,
                  left: 15,
                  right: 15),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                height: MediaQuery.of(context).size.height / 2,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            top: 5, left: 20, right: 20, bottom: 5),
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
                      Container(
                        padding:
                            const EdgeInsets.only(top: 15, left: 40, right: 40),
                        width: 350,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            if (formKey.currentState.validate()) {
                              QuerySnapshot querySnapshot = await users
                                  .where('email',
                                      isEqualTo: emailController.text)
                                  .get();
                              passwordList = querySnapshot.docs
                                  .map((doc) => doc.get('password'))
                                  .toList();
                              usernameList = querySnapshot.docs
                                  .map((doc) => doc.get('username'))
                                  .toList();
                              if (passwordList.isNotEmpty &&
                                  passwordList[0] == passwordController.text) {
                                Navigator.pop(context);
                                GlobalHolder.email = emailController.text;
                                GlobalHolder.password = passwordController.text;
                                GlobalHolder.username = usernameList[0];
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
                                showErrorDialog(context);
                              }
                            }
                          },
                          icon: const Icon(Icons.login),
                          label: const Text("Login"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 30, left: 120, right: 120),
              width: 350,
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
                    onTap: () => registerDialog(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Dialog for error with wrong email or password input
  showErrorDialog(BuildContext context) {
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

  // Dialog for creating account
  registerDialog(BuildContext context) {
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
                                  bool emailValid = RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(emailController.text);
                                  if (value == null || value.isEmpty) {
                                    return 'This field cant be empty';
                                  }
                                  if (emailValid == false) {
                                    return 'Invalid email';
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
                                  child: const Text("Create Account"),
                                ),
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
