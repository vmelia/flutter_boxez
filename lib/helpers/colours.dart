import 'package:flutter/material.dart';

class Colours {
  static MaterialColor convertToColour(int colour) => _colours[colour];
  static int convertFromColour(MaterialColor colour) => colour.value;  //ToDo: Update.

  static const List<MaterialColor> _colours = <MaterialColor>[
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
  ];

  static int get count => _colours.length;
}
