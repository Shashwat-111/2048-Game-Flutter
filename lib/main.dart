import 'package:flutter/material.dart';
import 'package:game_2048/game_logic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List all;
  @override
  void initState() {
    all = [
      [16, 16, 2, 0],
      [2, 0, 2, 2],
      [0, 2, 0, 4],
      [2, 2, 0, 2]
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List newList = (getSingleList(all));

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.height / 2,
                child: GridView.builder(
                  itemCount: newList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.black,
                      height: 10,
                      width: 30,
                      child: Center(
                          child: Text(
                        newList[index].toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.height / 17),
                      )),
                    );
                  },
                ),
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      all = gameLogic(all: all, task: "D");
                    });
                  },
                  child: const Text("Down")),
              TextButton(
                  onPressed: () {
                    setState(() {
                      all = gameLogic(all: all, task: "U");
                    });
                  },
                  child: const Text("UP")),
              TextButton(
                  onPressed: () {
                    setState(() {
                      all = gameLogic(all: all, task: "L");
                    });
                  },
                  child: const Text("Left")),
              TextButton(
                  onPressed: () {
                    setState(() {
                      all = gameLogic(all: all, task: "R");
                    });
                  },
                  child: const Text("Right"))
            ],
          ),
        ),
      ),
    );
  }
}

List getSingleList(List original) {
  List converted = [];
  for (int i = 0; i <= 3; i++) {
    for (int j = 0; j <= 3; j++) {
      converted.add(original[i][j]);
    }
  }
  return converted;
}
