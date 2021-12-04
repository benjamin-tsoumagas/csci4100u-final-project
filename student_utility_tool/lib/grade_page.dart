import 'package:flutter/material.dart';

// Global Variable
final List<List<TextEditingController>> textControllers = [];

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
              ElevatedButton(onPressed: () {}, child: const Text("Calculate")),
              ElevatedButton(
                  onPressed: () {
                    for (var controller in textControllers) {
                      controller[0].clear();
                      controller[1].clear();
                      controller[2].clear();
                    }
                  },
                  child: const Text("Clear All"))
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class GradeCalculator extends StatefulWidget {
  const GradeCalculator({Key? key}) : super(key: key);

  @override
  _GradeCalculatorState createState() => _GradeCalculatorState();
}

class _GradeCalculatorState extends State<GradeCalculator> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          List<TextEditingController> temp = [
            TextEditingController(),
            TextEditingController(),
            TextEditingController()
          ];
          textControllers.add(temp);

          return Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 10),
                  Flexible(
                      flex: 2,
                      child: TextField(
                          controller: textControllers[index][0],
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()))),
                  const SizedBox(width: 10),
                  Flexible(
                      child: TextField(
                          controller: textControllers[index][1],
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()))),
                  const SizedBox(width: 10),
                  Flexible(
                      child: TextField(
                          controller: textControllers[index][2],
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()))),
                  const SizedBox(width: 10),
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
