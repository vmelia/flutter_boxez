import 'package:flutter/material.dart';

class Constants {
  // Game.
  static const int gridStart = -3;
  static const int gridEnd = 3;
  static const int gridSize = gridEnd - gridStart + 1;

  // BoxWidgets.
  static const double boxPadding = 5.0;
  static const double boxRadius = 30.0;

  // Colours.
  static const List<MaterialColor> colours = <MaterialColor>[
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
  ];
}
