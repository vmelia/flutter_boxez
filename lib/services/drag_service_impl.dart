import 'dart:ui';
import 'package:flutter_boxez/types.dart';

import '../interfaces.dart';

class DragServiceImpl implements DragService {
  DragServiceImpl(this.gameService);
  final GameService gameService;

  late Box _draggedBox;
  late Offset _tappedLocation;
  late Offset _startLocation;

  @override
  void onPanStart(Box box, Offset globalPosition) {
    _draggedBox = box;
    _tappedLocation = globalPosition;
    _startLocation = box.location;
  }

  @override
  void onPanUpdate(Offset globalPosition) {
    final newLocation = _startLocation + globalPosition - _tappedLocation;
    _draggedBox.location = newLocation;
    onChanged!();
  }

  @override
  void onPanEnd(Offset globalPosition) {}

  @override
  VoidCallback? onChanged;
}
