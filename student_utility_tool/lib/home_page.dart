// @dart=2.9

import 'package:flutter/material.dart';
import 'navigation_drawer.dart';

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
                            "https://shepherdtraveller.com/wp-content/uploads/2021/04/oeschinensee-camping-Lakes-in-Switzerland-1536x1024.jpg"),
                        fit: BoxFit.fill)),
              ),
            )),
        body: columnWidget());
  }

  Widget columnWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [locationWidget(), const SizedBox(height: 30), iconWidgets()],
    );
  }

  Widget locationWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text("Oeschinen Lake Campground",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            const SizedBox(height: 10),
            Text("Kandersteg, Switzerland",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.5), fontSize: 18)),
          ],
        ),
        const SizedBox(width: 100),
        const FavoriteIcon()
      ],
    );
  }

  Widget iconWidgets() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildButtonColumn(Colors.blue, Icons.call, "CALL"),
        _buildButtonColumn(Colors.blue, Icons.near_me, "ROUTE"),
        _buildButtonColumn(Colors.blue, Icons.share, "SHARE")
      ],
    );
  }

  /// This helper function returns a column widget with a button and text label.
  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(onPressed: () {}, icon: Icon(icon), color: color),
        Text(
          label,
          style: TextStyle(color: color),
        )
      ],
    );
  }
}

class FavoriteIcon extends StatefulWidget {
  const FavoriteIcon({Key key}) : super(key: key);

  @override
  _FavoriteIconState createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  Color _color = Colors.red;
  double _counter = 2.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        ElevatedButton.icon(
            onPressed: () {
              setState(() {
                if (_color == Colors.red) {
                  _color = Colors.white;
                  _counter--;
                } else {
                  _color = Colors.red;
                  _counter++;
                }
              });
            },
            icon: Icon(Icons.favorite, color: _color),
            label: Text('$_counter')),
      ],
    );
  }
}
