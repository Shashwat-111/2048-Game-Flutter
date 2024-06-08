import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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
              child: Stack(alignment: Alignment.center, children: [
                Container(
                    color: const Color.fromRGBO(250, 248, 239,1)), //for background color
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color.fromRGBO(187, 173, 160, 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 1.7,
                      width: MediaQuery.of(context).size.height / 1.7,
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
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: Color.fromRGBO(205, 193, 180, 1)),
                              height: 10,
                              width: 30,
                              child: Center(
                                  child: Text(
                                newList[index].toString(),
                                style: TextStyle(
                                    color:
                                        const Color.fromRGBO(120, 111, 102, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.height /
                                            17),
                              )),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
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
