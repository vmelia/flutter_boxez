import 'dart:ui';
import 'package:flutter_boxez/types.dart';

import '../interfaces.dart';

class DragServiceImpl implements DragService {
  DragServiceImpl(this.gameDataService);
  final GameDataService gameDataService;

  late double _boxWidth;
  late Offset? _globalStartLocation;
  late Map<Location, Box> _draggedRow;
  late Map<Location, Box> _draggedColumn;

  @override
  void onPanStart(Offset globalLocation, Location location, double boxWidth) {
    _globalStartLocation = globalLocation;
    _boxWidth = boxWidth;

    _draggedColumn = gameDataService.getSelectedColumn(location.dx.toInt());
    _draggedRow = gameDataService.getSelectedRow(location.dy.toInt());
  }

  @override
  void onPanUpdate(Offset globalLocation) {
    _stillMovingBoxes(globalLocation);
  }

  @override
  void onPanEnd(Offset globalLocation) {
    _finishedMovingBoxes(globalLocation);
    _reset();
  }

  @override
  BoxesUpdated? boxesFinished;

  @override
  BoxesUpdated? boxesMoving;

  void _stillMovingBoxes(Offset globalLocation) {
    final draggingingHorizontally = _draggingHorizontally(globalLocation);
    final localDelta = _calculatelocalDelta(globalLocation, false);

    if (draggingingHorizontally) {
      _updateBoxes(_draggedColumn, Location(0, 0), false);
      _updateBoxes(_draggedRow, localDelta, false);
    } else {
      _updateBoxes(_draggedRow, Location(0, 0), false);
      _updateBoxes(_draggedColumn, localDelta, false);
    }
  }

  void _finishedMovingBoxes(Offset globalLocation) {
    final draggingingHorizontally = _draggingHorizontally(globalLocation);
    final localDelta = _calculatelocalDelta(globalLocation, true);

    if (draggingingHorizontally) {
      _updateBoxes(_draggedRow, localDelta, true);
    } else {
      _updateBoxes(_draggedColumn, localDelta, true);
    }
  }

  bool _draggingHorizontally(Offset globalLocation) {
    final globalDelta = globalLocation - _globalStartLocation!;
    return globalDelta.dx.abs() > globalDelta.dy.abs();
  }

  Location _calculatelocalDelta(Offset globalLocation, bool snapToCell) {
    final globalDelta = globalLocation - _globalStartLocation!;
    final draggingingHorizontally = globalDelta.dx.abs() > globalDelta.dy.abs();

    final localDelta = globalDelta / _boxWidth;
    final localDeltaSnappedToColumnAndRow =
        draggingingHorizontally ? Location(localDelta.dx, 0) : Location(0, localDelta.dy);

    return snapToCell ? _snapToCell(localDeltaSnappedToColumnAndRow) : localDeltaSnappedToColumnAndRow;
  }

  void _updateBoxes(Map<Location, Box> boxes, Location delta, bool done) {
    List<Box> updatedBoxes = <Box>[];
    for (final entry in boxes.entries) {
      final updatedBox = entry.value.copyWith(location: entry.key + delta);
      updatedBoxes.add(updatedBox);
    }

    if (done) {
      boxesFinished!(updatedBoxes);
    } else {
      boxesMoving!(updatedBoxes);
    }
  }

  _snapToCell(Location localLocation) =>
    Location(localLocation.dx.round().toDouble(), localLocation.dy.round().toDouble());

  _reset() {
    _globalStartLocation = null;
    _draggedRow = {};
    _draggedColumn = {};
  }
}
