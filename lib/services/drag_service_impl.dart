import 'package:flutter/material.dart';
import 'package:flutter_boxez/types.dart';

import '../extensions.dart';
import '../interfaces.dart';

class DragServiceImpl implements DragService {
  DragServiceImpl(this.gameService);
  final GameService gameService;

  late Size _screenSize;
  late Location? draggingLocation;
  late Box? draggingBox;

  @override
  void initialize(Size screenSize) => _screenSize = screenSize;

  @override
  void onPanStart(DragStartDetails details) {
    draggingLocation = null;
    draggingBox = null;

    final box = _screenSize.getTappedBox(details.globalPosition, gameService.game);
    if (box == null) return;

    draggingBox = box;
  }

  @override
  void onPanUpdate(DragUpdateDetails details) {}

  @override
  void onPanEnd(DragEndDetails details) {}
}
