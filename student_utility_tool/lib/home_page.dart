// @dart=2.9

import 'package:flutter/material.dart';
import 'navigation_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  final String title = "Student's Utility Tool";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      drawer: NavigationDrawerWidget(),
      body: Column(),
    );
  }
}
