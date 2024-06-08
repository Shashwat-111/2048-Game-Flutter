import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:game_2048/colors.dart';
import 'package:game_2048/game_logic.dart';
import 'package:game_2048/tile_class.dart';

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
  late List tiles;
  @override
  void initState() {
    all = newGameTiles();
    tiles = categoriseTiles(all);
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
                          tiles = categoriseTiles(all);
                        })
                      }),
              DownIntent: CallbackAction<DownIntent>(
                  onInvoke: (intent) => {
                        setState(() {
                          all = gameLogic(all: all, task: "D");
                          all = randomTwoGenerator(all);
                          tiles = categoriseTiles(all);
                        })
                      }),
              LeftIntent: CallbackAction<LeftIntent>(
                  onInvoke: (intent) => {
                        setState(() {
                          all = gameLogic(all: all, task: "L");
                          all = randomTwoGenerator(all);
                          tiles = categoriseTiles(all);
                        })
                      }),
              RightIntent: CallbackAction<RightIntent>(
                  onInvoke: (intent) => {
                        setState(() {
                          all = gameLogic(all: all, task: "R");
                          all = randomTwoGenerator(all);
                          tiles = categoriseTiles(all);
                        })
                      }),
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: (){
                    setState(() {
                      all = newGameTiles();
                      tiles = categoriseTiles(all);
                    });
                  }, child: const Text("New Game")),
                  Stack(alignment: Alignment.center, children: [
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
                              itemCount: tiles.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                              itemBuilder: (context, index) {
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: tiles[index].fillColor
                                      //Color.fromRGBO(205, 193, 180, 1)
                                  ),
                                  height: 10,
                                  width: 30,
                                  child: Center(
                                      child: Text(
                                    tiles[index].number.toString(),
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

List categoriseTiles(all){
  List tiles = [];
  List singlelist = getSingleList(all);
  for(int i = 0;i<16;i++){
    Tile tile = Tile(number: singlelist[i], fillColor: tileColors[singlelist[i]] ?? emptyTileColor);
    tiles.add(tile);
  }
  return tiles;
  }
  List newGameTiles(){
   List all = [
     [0, 0, 0, 0],
     [0, 0, 0, 0],
     [0, 0, 0, 0],
     [0, 0, 0, 0]
   ];
    all = randomTwoGenerator(all);
    all = randomTwoGenerator(all);
    return all;
}