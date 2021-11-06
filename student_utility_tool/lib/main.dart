import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_utility_tool/account.dart';
import 'package:student_utility_tool/start_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: StartPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  final String title = "Student's Utility Tool";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = -1;
  List<Map> _accounts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              //Listview of made accounts
              Flexible(
                fit: FlexFit.loose,
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: ListTile(
                        selected: false,
                        tileColor: _selectedIndex == index ? Colors.blue : null,
                        title: Text(_accounts[index]['username']),
                        subtitle: Text(_accounts[index]['email']),
                        trailing: Row(
                          children: [
                            //Button to sign in to account
                            ElevatedButton(
                                onPressed: () {}, child: const Text("Sign in")),
                            ElevatedButton(
                              onPressed: () {},
                              child:
                                  const Icon(Icons.delete, color: Colors.white),
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                            )
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    height: 5,
                    color: Colors.grey.shade200,
                  ),
                  itemCount: _accounts.length,
                ),
              ),
              //Button to create a new account
              Container(
                padding: const EdgeInsets.only(top: 50),
                child: ElevatedButton(
                    child: const Text("New account"),
                    onPressed: () {
                      //TODO: add transition to make new account
                      log("Make new account");
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
