import 'dart:async';

import 'package:flutter/material.dart';
import 'package:student_utility_tool/main.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  //Switches page to the home screen
  startApp() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  //Sets the page to switch after 3 seconds
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      startApp();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Stack(
            children: [
              //TODO: Insert background image here

              //Start page content
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.25,
                    height: MediaQuery.of(context).size.height / 2,
                    child: const FittedBox(
                      fit: BoxFit.contain,
                      child: Text("Student's Utility Tool"),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.height / 5,
                    child: const FittedBox(
                      fit: BoxFit.contain,
                      child: Text("Welcome!"),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.height / 5,
                    child: const FittedBox(
                      fit: BoxFit.contain,
                      child: Text("Please wait for the app to load."),
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
}
