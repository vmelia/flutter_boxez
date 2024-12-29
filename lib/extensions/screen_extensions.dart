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

  List<Widget> convertBoxesIntoWidgets(Game game) => game.grid.entries
      .map(
        (entry) => Positioned.fromRect(
          rect:getRect(entry.key),
          child: BoxWidget(box: entry.value),
        ),
      )
      .toList();

  Box? getTappedBox(Offset globalPosition, Game game) {
    for (final entry in game.grid.entries) {
      final isHit = getRect(entry.key).contains(globalPosition);
      if (isHit) return entry.value;
    }

    return null;
  }
}
