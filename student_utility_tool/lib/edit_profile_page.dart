// @dart=2.9
// ignore_for_file: avoid_unnecessary_containers, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'global_content_holder.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final users = FirebaseFirestore.instance.collection('user');

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Edit Profile"),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 4,
                        color: Theme.of(context).scaffoldBackgroundColor),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(0, 10))
                    ],
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        'https://www.seekpng.com/png/detail/41-410093_circled-user-icon-user-profile-icon-png.png',
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  TextField(
                    readOnly: true,
                    controller: usernameController,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelText: "Username",
                      contentPadding: const EdgeInsets.only(bottom: 3),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: GlobalHolder.username,
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          editUsernameDialog(usernameController);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Email",
                      contentPadding: const EdgeInsets.only(bottom: 3),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: GlobalHolder.email,
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    readOnly: true,
                    obscureText: true,
                    controller: passwordController,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelText: "Password",
                      contentPadding: const EdgeInsets.only(bottom: 3),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText:
                          GlobalHolder.password.replaceAll(RegExp("."), "*"),
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          editPasswordDialog(passwordController);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Dialog for editing username
  editUsernameDialog(TextEditingController usernameController) {
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
                        height: height - 450,
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
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState.validate()) {
                                      users
                                          .where('email',
                                              isEqualTo: GlobalHolder.email)
                                          .get()
                                          .then(
                                        (querySnapshot) {
                                          querySnapshot.docs.forEach(
                                            (documentSnapshot) {
                                              documentSnapshot.reference.update(
                                                {
                                                  'username':
                                                      usernameController.text,
                                                },
                                              );
                                            },
                                          );
                                        },
                                      );
                                      GlobalHolder.username =
                                          usernameController.text;
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Text("Save"),
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

  // Dialog for editing password
  editPasswordDialog(TextEditingController passwordController) {
    TextEditingController oldPasswordController = TextEditingController();
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
                        height: height - 350,
                        width: width,
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                obscureText: isObscure,
                                controller: oldPasswordController,
                                decoration: InputDecoration(
                                  labelText: "Old Password",
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
                                  if (value != GlobalHolder.password) {
                                    return 'Wrong password';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                obscureText: isObscure,
                                controller: passwordController,
                                decoration: InputDecoration(
                                  labelText: "New Password",
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
                                      users
                                          .where('email',
                                              isEqualTo: GlobalHolder.email)
                                          .get()
                                          .then(
                                        (querySnapshot) {
                                          querySnapshot.docs.forEach(
                                            (documentSnapshot) {
                                              documentSnapshot.reference.update(
                                                {
                                                  'password':
                                                      passwordController.text,
                                                },
                                              );
                                            },
                                          );
                                        },
                                      );
                                      GlobalHolder.password =
                                          passwordController.text;
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Text("Save"),
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
