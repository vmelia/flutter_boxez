import 'package:flutter/material.dart';

import '../types.dart';

extension LocationExtensions on Location {
  Rect getRect(Size screenSize) {
    final boxWidth = screenSize.shortestSide / Constants.gridSize;
    final xOffset = screenSize.width / 2 + x * boxWidth;
    final yOffset = screenSize.height / 2 + y * boxWidth;

    return Rect.fromCenter(center: Offset(xOffset, yOffset), width: boxWidth, height: boxWidth);
  }
}
