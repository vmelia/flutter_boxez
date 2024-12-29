import 'package:flutter/material.dart';

import '../interfaces.dart';
import '../types.dart';

class ScreenServiceImpl implements ScreenService {
  late Size _screenSize;

  @override
  void initialize({required Size screenSize}) {
    _screenSize = screenSize;
  }

  @override
  Rect getRect(Location location) {
    final boxWidth = _screenSize.shortestSide / Constants.gridSize;
    final x = _screenSize.width / 2 + location.x * boxWidth;
    final y = _screenSize.height / 2 + location.y * boxWidth;

    return Rect.fromCenter(center: Offset(x, y), width: boxWidth, height: boxWidth);
  }
}
