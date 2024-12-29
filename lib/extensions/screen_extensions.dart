import 'package:flutter/material.dart';

import '../types.dart';
import '../widgets.dart';

extension ScreenExtensions on Size {
  Rect getRect(Location location) {
    final boxWidth = shortestSide / Constants.gridSize;
    final x = width / 2 + location.x * boxWidth;
    final y = height / 2 + location.y * boxWidth;

    return Rect.fromCenter(center: Offset(x, y), width: boxWidth, height: boxWidth);
  }

  List<Widget> convertBoxesIntoWidgets(List<Box> boxes) => boxes
      .map(
        (box) => Positioned.fromRect(
          rect:getRect(box.location),
          child: BoxWidget(box: box),
        ),
      )
      .toList();

  Box? getTappedBox(Offset globalCoordinates, List<Box> boxes) {
    for (final box in boxes) {
      final isHit = box.getRect(this).contains(globalCoordinates);
      if (isHit) return box;
    }

    return null;
  }
}
