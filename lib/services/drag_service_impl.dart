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
    _updateSelectedBoxes(globalLocation, false);
  }

  @override
  void onPanEnd(Offset globalLocation) {
    _updateSelectedBoxes(globalLocation, true);
    _reset();
  }

  @override
  BoxesUpdated? boxesUpdated;

  void _updateSelectedBoxes(Offset globalLocation, bool done) {
    final globalDelta = globalLocation - _globalStartLocation!;
    final draggingingHorizontally = globalDelta.dx.abs() > globalDelta.dy.abs();

    final localDelta = globalDelta / _boxWidth;
    final localDeltaSnapped = draggingingHorizontally ? Offset(localDelta.dx, 0) : Offset(0, localDelta.dy);
    final localDeltaSnappedToCell = done ? _snapToCell(localDeltaSnapped) : localDeltaSnapped;

    if (draggingingHorizontally) {
      _updateBoxes(_draggedColumn, Offset(0, 0));
      _updateBoxes(_draggedRow, localDeltaSnappedToCell);
    } else {
      _updateBoxes(_draggedRow, Offset(0, 0));
      _updateBoxes(_draggedColumn, localDeltaSnappedToCell); 
    }
  }

  void _updateBoxes(Map<Offset, Box> boxes, Offset localDelta) {
    List<Box> updatedBoxes = <Box>[];
    for (final entry in boxes.entries) {
      final updatedBox = entry.value.copyWith(location: entry.key + localDelta);
      updatedBoxes.add(updatedBox);
    }
    boxesUpdated!(updatedBoxes, localDelta == Offset(0, 0));  //ToDo: Not very clear.
  }

  _snapToCell(Offset localLocation) => Offset(localLocation.dx.round().toDouble(), localLocation.dy.round().toDouble());

  _reset() {
    _globalStartLocation = null;
    _draggedRow = {};
    _draggedColumn = {};
  }
}
