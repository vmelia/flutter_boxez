import 'package:flutter/material.dart';  //ToDo: Remove.

import '../interfaces.dart';
import '../types.dart';
import '../widgets.dart';

class ScreenServiceImpl implements ScreenService {
  late Size _screenSize;

  @override
  void initialize(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;  //ToDo: Move.
  }

  @override
  Size get screenSize => _screenSize;

  @override
  List<Widget> convertBoxesIntoWidgets(Game game) => game.boxes
      .map(
        (box) => Positioned.fromRect(
          rect: _getRect(box.location),
          child: BoxWidget(box: box),
        ),
      )
      .toList();

  @override
  Box? getTappedBox(Offset globalPosition, Game game) {
    for (final box in game.boxes) {
      final isHit = _getRect(box.location).contains(globalPosition);
      if (isHit) return box;
    }

    return null;
  }

  Rect _getRect(Location location) {
    final boxWidth = _screenSize.shortestSide / Constants.gridSize;
    final x = _screenSize.width / 2 + location.x * boxWidth;
    final y = _screenSize.height / 2 + location.y * boxWidth;

    return Rect.fromCenter(center: Offset(x, y), width: boxWidth, height: boxWidth);
  }
}
