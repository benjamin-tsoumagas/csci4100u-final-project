// @dart=2.9

import 'package:flutter/material.dart';
import 'map_page.dart';
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
                          "https://www.edgeip.com/images/FCK/Image/201908/20-OntarioTech-Get-to-Know-Our-Community-SIC.jpg"),
                      fit: BoxFit.fitHeight)),
            ),
          )),
      body: columnWidget(context),
      drawer: const NavigationDrawerWidget(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {},
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
