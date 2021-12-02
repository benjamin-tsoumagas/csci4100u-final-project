// @dart=2.9
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StreamBuilderWidget extends StatefulWidget {
  const StreamBuilderWidget({Key key}) : super(key: key);

  @override
  _StreamBuilderWidgetState createState() => _StreamBuilderWidgetState();
}

class _StreamBuilderWidgetState extends State<StreamBuilderWidget> {
  final users = FirebaseFirestore.instance.collection('user');
  int _selectedIndex = -1;
  var documentID;

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
                      tileColor: _selectedIndex == index ? Colors.blue : null,
                      title: Text(snapshot.data.docs[index]['username']),
                      subtitle: Text(snapshot.data.docs[index]['email']),
                      trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              _showAlertDialog(context);
                            });
                          },
                          icon: const Icon(Icons.delete)),
                      onTap: () {
                        setState(() {
                          if (_selectedIndex == index) {
                            //Code to prompt password
                            //If successful password, go to user home
                          }
                          _selectedIndex = index;
                          documentID = snapshot.data.docs[index].id;
                        });
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
        }).then((value) {
      if (value == "Yes") {
        final users = FirebaseFirestore.instance.collection('user');
        users.doc(documentID).delete();
      }
    });
  }
}
