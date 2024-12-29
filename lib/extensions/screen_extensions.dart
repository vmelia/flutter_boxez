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

  List<Widget> convertBoxesIntoWidgets(Game game) => game.boxes
      .map(
        (box) => Positioned.fromRect(
          rect:getRect(box.location),
          child: BoxWidget(box: box),
        ),
      )
      .toList();

  Box? getTappedBox(Offset globalPosition, Game game) {
    for (final box in game.boxes) {
      final isHit = getRect(box.location).contains(globalPosition);
      if (isHit) return box;
    }

    return null;
  }
}
