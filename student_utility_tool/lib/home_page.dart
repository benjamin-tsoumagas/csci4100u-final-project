// @dart=2.9

import 'package:flutter/material.dart';
import 'navigation_drawer.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(300.0),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://shared.ontariotechu.ca/shared/department/itsc/All%20Images/wallpapers-and-screensavers/desktop_768x1366--ontariotech_.jpg"),
                      fit: BoxFit.fitHeight)),
            ),
          )),
      body: columnWidget(),
      drawer: const NavigationDrawerWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Clipboard.setData(
              const ClipboardData(text: "https://ontariotechu.ca/"));
        },
        child: const Icon(Icons.share),
        backgroundColor: Colors.blue[900],
      ),
    );
  }

  Widget columnWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        const Text("Ontario Tech University",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            )),
        Container(
          padding: const EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
          child: const Text(
            "The University of Ontario Institute of Technology, corporately branded as Ontario Tech University or Ontario Tech, is a public research university located in Oshawa, Ontario, Canada. Ontario Tech's main campus is located on approximately 400 acres of land in the northern part of Oshawa.",
            style: TextStyle(color: Colors.black87, fontSize: 18.0),
          ),
        ),
      ],
    );
  }
}
