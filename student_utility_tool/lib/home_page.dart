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
      drawer: const NavigationDrawerWidget(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          SimpleNotification(context).quoteNotification();
        },
        child: const Icon(Icons.favorite),
      ),
    );
  }

  Widget columnWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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

class InspirationalQuote {
  String quote;
  String author;

  InspirationalQuote(this.quote, this.author);

  @override
  String toString() {
    return "$quote - $author";
  }
}

class SimpleNotification {
  BuildContext context;
  late FlutterLocalNotificationsPlugin notification;

  SimpleNotification(this.context) {
    initNotification();
  }

  //initialize notification
  initNotification() {
    notification = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    IOSInitializationSettings iOSInitializationSettings =
        IOSInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iOSInitializationSettings);

    notification.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

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
    randomQuote = users[Random().nextInt(users.length)];
    output = [randomQuote.quote, randomQuote.author];

    return output;
  }

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
