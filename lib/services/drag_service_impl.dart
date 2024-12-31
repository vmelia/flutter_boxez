import 'dart:ui';
import 'package:flutter_boxez/types.dart';

import '../interfaces.dart';

class DragServiceImpl implements DragService {
  DragServiceImpl(this.gameService);
  final GameService gameService;

  late Box? _draggedBox;
  late Rect? _boxRect;
  late Offset? _dragStartLocation;
  late Offset? _boxStartLocation;

  @override
  void onPanStart(Offset dragStartLocation, Box box, Rect boxRect) {
    _dragStartLocation = dragStartLocation;
    _draggedBox = box;
    _boxRect = boxRect;
    _boxStartLocation = box.location;
  }

  @override
  void onPanUpdate(Offset dragCurrentLocation) {
    final newLocation = _boxStartLocation! + (dragCurrentLocation - _dragStartLocation!) / _boxRect!.width;
    final updatedBox = _draggedBox!.copyWith(location: newLocation);
    boxesUpdated!([updatedBox]);
  }

  @override
  void onPanEnd(Offset dragEndLocation) {
    _reset();
  }

  @override
  BoxesUpdated? boxesUpdated;

  _reset() {
    _draggedBox = null;
    _boxRect = null;
    _dragStartLocation = null;
    _boxStartLocation = null;
  }
}
