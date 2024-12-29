import 'package:flutter/material.dart';

import '../types.dart';

class Box {
  Box({required this.location, required this.colour});
  final Location location;
  final MaterialColor colour;

  Rect getRect(Size screenSize) {
    final boxWidth = screenSize.shortestSide / Constants.gridSize;
    final x = screenSize.width / 2 + location.x * boxWidth;
    final y = screenSize.height / 2 + location.y * boxWidth;

    return Rect.fromCenter(center: Offset(x, y), width: boxWidth, height: boxWidth);
  }
}
