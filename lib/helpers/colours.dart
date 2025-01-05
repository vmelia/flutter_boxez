import 'package:flutter/material.dart';

class Colours {
  static int get count => _colours.length;

  static MaterialColor convertToColour(int colour) => _colours[colour];

  static const List<MaterialColor> _colours = <MaterialColor>[
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
  ];
}
