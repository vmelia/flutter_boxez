import 'dart:ui';
import 'package:flutter_boxez/types.dart';

import '../interfaces.dart';

class DragServiceImpl implements DragService {
  DragServiceImpl(this.gameDataService);
  final GameDataService gameDataService;

  late double _boxWidth;
  late Offset? _globalStartLocation;
  late Map<Offset, Box> _draggedRow;
  late Map<Offset, Box> _draggedColumn;

  @override
  void onPanStart(Offset globalLocation, Box box, double boxWidth) {
    _globalStartLocation = globalLocation;
    _boxWidth = boxWidth;

    _draggedRow = gameDataService.getSelectedRow(box);
    _draggedColumn = gameDataService.getSelectedColumn(box);
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
    final globalDelta = globalLocation - _globalStartLocation!;
    final draggingingHorizontally = globalDelta.dx.abs() > globalDelta.dy.abs();

    final localDelta = globalDelta / _boxWidth;
    final localDeltaSnapped = draggingingHorizontally ? Offset(localDelta.dx, 0) : Offset(0, localDelta.dy);

    if (draggingingHorizontally) {
      _updateBoxes(_draggedColumn, Offset(0, 0), false);
      _updateBoxes(_draggedRow, localDeltaSnapped, false);
    } else {
      _updateBoxes(_draggedRow, Offset(0, 0), false);
      _updateBoxes(_draggedColumn, localDeltaSnapped, false);
    }
  }

  void _finishedMovingBoxes(Offset globalLocation) {
    final globalDelta = globalLocation - _globalStartLocation!;
    final draggingingHorizontally = globalDelta.dx.abs() > globalDelta.dy.abs();

    final localDelta = globalDelta / _boxWidth;
    final localDeltaSnapped = draggingingHorizontally ? Offset(localDelta.dx, 0) : Offset(0, localDelta.dy);
    final localDeltaSnappedToCell = _snapToCell(localDeltaSnapped);

    if (draggingingHorizontally) {
      //_updateBoxes(_draggedColumn, Offset(0, 0));
      _updateBoxes(_draggedRow, localDeltaSnappedToCell, true);
    } else {
      //_updateBoxes(_draggedRow, Offset(0, 0));
      _updateBoxes(_draggedColumn, localDeltaSnappedToCell, true);
    }
  }

  void _updateBoxes(Map<Offset, Box> boxes, Offset delta, bool done) {
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

  _snapToCell(Offset localLocation) => Offset(localLocation.dx.round().toDouble(), localLocation.dy.round().toDouble());

  _reset() {
    _globalStartLocation = null;
    _draggedRow = {};
    _draggedColumn = {};
  }
}
