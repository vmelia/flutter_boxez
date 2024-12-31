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
  void onPanStart(Offset dragLocation, Box box, Rect boxRect) {
    _dragStartLocation = dragLocation;
    _draggedBox = box;
    _boxRect = boxRect;
    _boxStartLocation = box.location;
  }

  @override
  void onPanUpdate(Offset dragLocation) {
    final newLocation = _calculateNewLocation(dragLocation);
    final updatedBox = _draggedBox!.copyWith(location: newLocation);
    boxesUpdated!([updatedBox]);
  }

  @override
  void onPanEnd(Offset dragLocation) {
    final newLocation = _calculateNewLocation(dragLocation);
    final updatedBox = _draggedBox!.copyWith(location: newLocation);
    boxesUpdated!([updatedBox]);

    _reset();
  }

  @override
  BoxesUpdated? boxesUpdated;

  Offset _calculateNewLocation(Offset dragLocation) {
    final newLocation = _boxStartLocation! + (dragLocation - _dragStartLocation!) / _boxRect!.width;
    return _snapToColumnOrRow(newLocation);
  }

  Offset _snapToColumnOrRow(Offset requestedLocation) {
    final deltaX = _boxStartLocation!.dx - requestedLocation.dx;
    final deltaY = _boxStartLocation!.dy - requestedLocation.dy;
    if (deltaX.abs() > deltaY.abs()) {
      // Horizonal dragging.
      return Offset(requestedLocation.dx, _boxStartLocation!.dy);
    }
    // vertical dragging.
    return Offset(_boxStartLocation!.dx, requestedLocation.dy);
  }

  _reset() {
    _draggedBox = null;
    _boxRect = null;
    _dragStartLocation = null;
    _boxStartLocation = null;
  }
}
