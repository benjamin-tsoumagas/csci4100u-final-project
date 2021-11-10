// @dart=2.9
import 'package:flutter/material.dart';
import 'streambuilder.dart';

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
      body: Container(child: StreamBuilderWidget(), padding: EdgeInsets.all(40),)
    );
  }
}
