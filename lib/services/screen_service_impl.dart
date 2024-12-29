import 'package:flutter/material.dart';

import '../interfaces.dart';
import '../types.dart';

class ScreenServiceImpl implements ScreenService {
  ScreenServiceImpl({required this.screenSize});
  final Size screenSize;

  @override
  Rect getRect(Box box) {
    final boxWidth = screenSize.shortestSide / Constants.gridSize;
    final x = screenSize.width / 2 + box.location.x * boxWidth;
    final y = screenSize.height / 2 + box.location.y * boxWidth;

    return Rect.fromCenter(center: Offset(x, y), width: boxWidth, height: boxWidth);
  }
}