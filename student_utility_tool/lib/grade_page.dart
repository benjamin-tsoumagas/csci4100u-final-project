import 'package:flutter/material.dart';

class GradeCalculatorPage extends StatelessWidget {
  const GradeCalculatorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Grade Calculator"),
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text("Name (Optional)", style: TextStyle(fontSize: 20)),
                Text("Grade (%)", style: TextStyle(fontSize: 20)),
                Text("Weight (%)", style: TextStyle(fontSize: 20))
              ],
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(20),
              child: Card(child: GradeCalculator()),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {}, child: const Text("Calculate")),
                ElevatedButton(onPressed: () {}, child: const Text("Clear All"))
              ],
            ),
            const SizedBox(height: 20),
          ],
        ));
  }
}

class GradeCalculator extends StatefulWidget {
  GradeCalculator({Key? key}) : super(key: key);

  @override
  _GradeCalculatorState createState() => _GradeCalculatorState();
}

class _GradeCalculatorState extends State<GradeCalculator> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Row(
                children: const [
                  SizedBox(width: 10),
                  Flexible(
                      flex: 2,
                      child: TextField(
                          decoration:
                              InputDecoration(border: OutlineInputBorder()))),
                  SizedBox(width: 10),
                  Flexible(
                      child: TextField(
                          decoration:
                              InputDecoration(border: OutlineInputBorder()))),
                  SizedBox(width: 10),
                  Flexible(
                      child: TextField(
                          decoration:
                              InputDecoration(border: OutlineInputBorder()))),
                  SizedBox(width: 10),
                ],
              ),
              const SizedBox(
                height: 20,
              )
            ],
          );
        });
  }
}
