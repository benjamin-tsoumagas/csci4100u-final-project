// @dart=2.9
import 'package:flutter/material.dart';
import 'streambuilder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key key}) : super(key: key);

  final String title = "Student's Utility Tool";

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Container(
              child: const StreamBuilderWidget(),
              padding: const EdgeInsets.all(40),
            )),
            Container(
              child: ElevatedButton(
                  onPressed: () {
                    _customDialog();
                  },
                  child: const Text("New Account")),
              padding: const EdgeInsets.only(bottom: 100),
            )
          ],
        ));
  }

  _customDialog() {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Builder(builder: (BuildContext context) {
              var height = MediaQuery.of(context).size.height;
              var width = MediaQuery.of(context).size.width;

              return SizedBox(
                  height: height - 700,
                  width: width,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: usernameController,
                          decoration:
                              const InputDecoration(labelText: "Username"),
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
                          decoration: const InputDecoration(labelText: "Email"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field cant be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 50),
                          child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState.validate()) {
                                  final users = FirebaseFirestore.instance
                                      .collection('user');
                                  users.add({
                                    'username': usernameController.text,
                                    'email': emailController.text
                                  });
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text("Create Account")),
                        )
                      ],
                    ),
                  ));
            }),
          );
        });
  }
}
