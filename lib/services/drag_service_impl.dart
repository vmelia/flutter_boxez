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
    final newLocationSnapped = _snapToColumnOrRow(newLocation);

    final updatedBox = _draggedBox!.copyWith(location: newLocationSnapped);
    boxesUpdated!([updatedBox]);
  }

  @override
  void onPanEnd(Offset dragEndLocation) {
    // final newLocation = _boxStartLocation! + (dragEndLocation - _dragStartLocation!) / _boxRect!.width;
    // final newLocationSnapped = _snapToColumnOrRow(newLocation);

    // final updatedBox = _draggedBox!.copyWith(location: newLocationSnapped);
    // boxesUpdated!([updatedBox]);

    _reset();
  }

  @override
  BoxesUpdated? boxesUpdated;

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
