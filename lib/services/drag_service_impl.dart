import 'package:flutter/material.dart';
import 'package:flutter_boxez/types.dart';

import '../extensions.dart';
import '../interfaces.dart';

class DragServiceImpl implements DragService {
  DragServiceImpl(this.gameService);
  final GameService gameService;

  late Size _screenSize;
  late Location? draggingLocation;
  late MaterialColor? draggingColour;

  @override
  void initialize(Size screenSize) => _screenSize = screenSize;

  @override
  void onPanStart(DragStartDetails details) {
    draggingLocation = null;
    draggingColour = null;

    final location = _screenSize.getTappedBox(details.globalPosition, gameService.game);
    if (location == null) return;

    draggingColour = gameService.game.grid[location];
  }

  @override
  void onPanUpdate(DragUpdateDetails details) {}

  @override
  void onPanEnd(DragEndDetails details) {}
}
