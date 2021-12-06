// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';
import 'package:flutter/material.dart';
import 'map_page.dart';
import 'navigation_drawer.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'dart:math';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //make the appBar an online picture of the university
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(300.0),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://www.edgeip.com/images/FCK/Image/201908/20-OntarioTech-Get-to-Know-Our-Community-SIC.jpg"),
                      fit: BoxFit.fitHeight)),
            ),
          )),
      body: columnWidget(context),
      //left-hanging drawer with options for the student
      drawer: const NavigationDrawerWidget(),
      //button to get a random inspirational quote as a notification
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          SimpleNotification(context).quoteNotification();
        },
        child: const Icon(Icons.favorite),
      ),
    );
  }

  //contains university name, phone number, address, and website url
  Widget columnWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //university name
          const SizedBox(height: 30),
          const Text(
            "Ontario Tech University",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 15, left: 2.0, bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //button to copy university phone number to clipboard
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Clipboard.setData(
                            const ClipboardData(text: "(905) 721-8668"));
                        SimpleNotification(context).selectNotification("Call");
                      },
                      icon: const Icon(
                        Icons.phone,
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "CALL",
                    )
                  ],
                ),
                //button to navigate from current location to university
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const MapPage(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.near_me,
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "ROUTE",
                    )
                  ],
                ),
                //button to copy university website link to clipboard
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Clipboard.setData(
                          const ClipboardData(text: "https://ontariotechu.ca/"),
                        );
                        SimpleNotification(context).selectNotification("Share");
                      },
                      icon: const Icon(
                        Icons.share,
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "SHARE",
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//class to store inspirational quote information
class InspirationalQuote {
  String quote;
  String author;

  InspirationalQuote(this.quote, this.author);

  @override
  String toString() {
    return "$quote - $author";
  }
}

//class used for notifications
class SimpleNotification {
  BuildContext context;
  late FlutterLocalNotificationsPlugin notification;

  //class constructor
  SimpleNotification(this.context) {
    initNotification();
  }

  //initialize notification
  initNotification() {
    notification = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    IOSInitializationSettings iOSInitializationSettings =
        const IOSInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iOSInitializationSettings);

    notification.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  //notification for either phone number or website url
  Future<String?> selectNotification(String? payload) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            title: Text("$payload Clicked"),
            content: payload == "Call"
                ? const Text("Phone number copied.")
                : payload == "Share"
                    ? const Text("Website information copied.")
                    : null));
  }

  //gets a random quote from the API given using HTTP requests
  Future<List<String>> getRandomQuote() async {
    var url = Uri.parse("https://type.fit/api/quotes");
    var response = await get(url);
    InspirationalQuote randomQuote;
    List<String> output = [];

    var data = jsonDecode(response.body);
    List<InspirationalQuote> users = [];
    for (var item in data) {
      users.add(InspirationalQuote(item["text"], item["author"]));
    }
    //picks a random quote from a list of quotes
    randomQuote = users[Random().nextInt(users.length)];
    output = [randomQuote.quote, randomQuote.author];

    return output;
  }

  //notification with a random quote
  Future<String?> quoteNotification() async {
    List<String> randQuote = await getRandomQuote();
    String content = randQuote[0];
    String author = randQuote[1];

    await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            title: Text("\"$content\""), content: Text("-$author-")));
  }
}
