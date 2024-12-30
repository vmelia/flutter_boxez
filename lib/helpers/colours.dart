import 'package:flutter/material.dart';

class Colours {
  static MaterialColor convertToColour(int colour) => _colours[colour];

  static int convertFromColour(MaterialColor colour) {
    for (var i = 0; i < _colours.length; i++) {
      if (_colours[i] == colour) {
        return i;
      }
    }
    return -1; //Error.
  }

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
