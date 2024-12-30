import 'dart:ui';
import 'package:flutter_boxez/types.dart';

import '../interfaces.dart';

class DragServiceImpl implements DragService {
  DragServiceImpl(this.gameService);
  final GameService gameService;

  late Box? draggedBox;
  late Offset? startPosition;

  @override
  void onPanStart(Box box, Offset position) {
    draggedBox = box;
    startPosition = position;
  }

  @override
  void onPanUpdate(Offset position) {
    
  }

  @override
  void onPanEnd(Offset position) {}
}
