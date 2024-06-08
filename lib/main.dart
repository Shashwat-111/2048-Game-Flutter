import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        body: Shortcuts(
          shortcuts: {
            LogicalKeySet(LogicalKeyboardKey.arrowUp): UpIntent(),
            LogicalKeySet(LogicalKeyboardKey.arrowDown): DownIntent(),
            LogicalKeySet(LogicalKeyboardKey.arrowLeft): LeftIntent(),
            LogicalKeySet(LogicalKeyboardKey.arrowRight): RightIntent(),
          },
          child: Actions(
            actions: {
              UpIntent: CallbackAction<UpIntent>(
                  onInvoke: (intent) => {
                        setState(() {
                          all = gameLogic(all: all, task: "U");
                          all = randomTwoGenerator(all);
                        })
                      }),
              DownIntent: CallbackAction<DownIntent>(
                  onInvoke: (intent) => {
                        setState(() {
                          all = gameLogic(all: all, task: "D");
                          all = randomTwoGenerator(all);
                        })
                      }),
              LeftIntent: CallbackAction<LeftIntent>(
                  onInvoke: (intent) => {
                        setState(() {
                          all = gameLogic(all: all, task: "L");
                          all = randomTwoGenerator(all);
                        })
                      }),
              RightIntent: CallbackAction<RightIntent>(
                  onInvoke: (intent) => {
                        setState(() {
                          all = gameLogic(all: all, task: "R");
                          all = randomTwoGenerator(all);
                        })
                      }),
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.height / 2,
                    child: Focus(
                      autofocus: true,
                      child: GridView.builder(
                        itemCount: newList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                                  fontSize:
                                      MediaQuery.of(context).size.height / 17),
                            )),
                          );
                        },
                      ),
                    ),
                  ),
                  // TextButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         all = gameLogic(all: all, task: "D");
                  //         all = randomTwoGenerator(all);
                  //       });
                  //     },
                  //     child: const Text("Down")),
                  // TextButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         all = gameLogic(all: all, task: "U");
                  //         all = randomTwoGenerator(all);
                  //       });
                  //     },
                  //     child: const Text("UP")),
                  // TextButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         all = gameLogic(all: all, task: "L");
                  //         all = randomTwoGenerator(all);
                  //       });
                  //     },
                  //     child: const Text("Left")),
                  // TextButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         all = gameLogic(all: all, task: "R");
                  //         all = randomTwoGenerator(all);
                  //       });
                  //     },
                  //     child: const Text("Right")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LeftIntent extends Intent {}

class RightIntent extends Intent {}

class DownIntent extends Intent {}

class UpIntent extends Intent {}
