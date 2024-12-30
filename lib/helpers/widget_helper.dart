import 'package:flutter/material.dart';

import '../types.dart';
import '../widgets.dart';

class WidgetHelper {
  static List<Widget> convertBoxesIntoWidgets(Game game, BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return game.boxes
        .map(
          (box) => Positioned.fromRect(
            rect: _getRect(box.location, screenSize),
            child: BoxWidget(box: box),
          ),
        )
        .toList();
  }

  static Box? getTappedBox(Offset globalPosition, Game game, BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    for (final box in game.boxes) {
      final isHit = _getRect(box.location , screenSize).contains(globalPosition);
      if (isHit) return box;
    }

    return null;
  }

  static Rect _getRect(Offset location, Size screenSize) {
    final boxWidth = screenSize.shortestSide / Constants.gridSize;
    final x = screenSize.width / 2 + location.dx * boxWidth;
    final y = screenSize.height / 2 + location.dy * boxWidth;

    return Rect.fromCenter(center: Offset(x, y), width: boxWidth, height: boxWidth);
  }
}
