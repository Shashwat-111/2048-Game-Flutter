import 'dart:ui';

import 'package:flutter/animation.dart';

class Tile {
  Tile({required int this.number, required Color this.fillColor});
  int? number;
  Color? fillColor;
  bool? active;
}