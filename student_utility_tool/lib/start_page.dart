// @dart=2.9
import 'dart:async';
import 'package:flutter/material.dart';
import 'user_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  //Sets the page to switch after a delay
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      setState(() {
        startApp();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            //Start page content
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Logo
                SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Image.asset('app_icon.png')),
                //App title
                SizedBox(
                    height: MediaQuery.of(context).size.height / 8,
                    child: const Text("Student's Utility Tool",
                        style: TextStyle(fontSize: 35, color: Colors.grey))),
                SizedBox(height: MediaQuery.of(context).size.height / 10),
                //Indeterminate progress bar
                progressBar()
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Switches page to the user login screen
  startApp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const UserPage()));
  }

  //Creates a widget for the indeterminant loading bar
  Widget progressBar() {
    return const LinearProgressIndicator(
        backgroundColor: Colors.grey, color: Colors.blue, minHeight: 10);
  }
}
