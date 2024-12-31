import 'package:flutter/material.dart';

import '../types.dart';
import '../widgets.dart';

class WidgetHelper {
  static List<Widget> convertBoxesIntoWidgets(Game game, BuildContext context) {
    return game.boxes
        .map(
          (box) => Positioned.fromRect(
            rect: getRect(box.location, context),
            child: BoxWidget(box: box),
          ),
        )
        .toList();
  }

  static Box? getTappedBox(Offset globalPosition, Game game, BuildContext context) {
    for (final box in game.boxes) {
      final isHit = getRect(box.location, context).contains(globalPosition);
      if (isHit) return box;
    }

    return null;
  }

  static Rect getRect(Offset location, BuildContext context) {
    final boxWidth = screenSize(context).shortestSide / Constants.gridSize;
    final x = screenSize(context).width / 2 + location.dx * boxWidth;
    final y = screenSize(context).height / 2 + location.dy * boxWidth;

    return Rect.fromCenter(center: Offset(x, y), width: boxWidth, height: boxWidth);
  }

  static Size screenSize(context) => MediaQuery.of(context).size;
}
