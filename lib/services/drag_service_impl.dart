import 'package:flutter/material.dart';  //ToDo: Remove.
import 'package:flutter_boxez/types.dart';

import '../interfaces.dart';

class DragServiceImpl implements DragService {
  DragServiceImpl(this.gameService, this.screenService);
  final GameService gameService;
  final ScreenService screenService;

  late Box? draggedBox;

  @override
  void onPanStart(DragStartDetails details) {
    draggedBox = null;

    final box = screenService.getTappedBox(details.globalPosition, gameService.game);
    if (box == null) return;

    draggedBox = box;
  }

  @override
  void onPanUpdate(DragUpdateDetails details) {}

  @override
  void onPanEnd(DragEndDetails details) {}
}
