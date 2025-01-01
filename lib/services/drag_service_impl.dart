import 'dart:ui';
import 'package:flutter_boxez/types.dart';

import '../helpers.dart';
import '../interfaces.dart';

class DragServiceImpl implements DragService {
  DragServiceImpl(this.gameService);
  final GameService gameService;

  late Rect? _boxRect;
  late Offset? _globalStartLocation;

  late Map<Offset, Box> _draggedRow;
  late Map<Offset, Box> _draggedColumn;

  @override
  void onPanStart(Offset globalLocation, Box box, Rect boxRect) {
    _globalStartLocation = globalLocation;
    _boxRect = boxRect;

    _draggedRow = gameService.game.getSelectedRow(box);
    _draggedColumn = gameService.game.getSelectedColumn(box);
  }

  @override
  void onPanUpdate(Offset globalLocation) {
    _updateSelectedGroup(globalLocation, false);
  }

  @override
  void onPanEnd(Offset globalLocation) {
    _updateSelectedGroup(globalLocation, true);
    _reset();
  }

  @override
  BoxesUpdated? boxesUpdated;

  void _updateSelectedGroup(Offset globalLocation, bool snapToCell) {
    final globalDelta = globalLocation - _globalStartLocation!;
    final localDelta = globalDelta / _boxRect!.width;
    final draggingingHorizontally = globalDelta.dx.abs() > globalDelta.dy.abs();
    final localDeltaSnapped = draggingingHorizontally ? Offset(localDelta.dx, 0) : Offset(0, localDelta.dy);
    final localDeltaSnappedToCell = snapToCell ? _snapToCell(localDeltaSnapped) : localDeltaSnapped;

    List<Box> updatedBoxes = <Box>[];
    if (draggingingHorizontally) {
      _updateBoxesToOriginalPositions(_draggedColumn);
      _updateBoxesToNewPositions(_draggedRow, localDeltaSnappedToCell);
    } else {
      _updateBoxesToOriginalPositions(_draggedRow);
      _updateBoxesToNewPositions(_draggedColumn, localDeltaSnappedToCell);
    }
    boxesUpdated!(updatedBoxes);
  }

  void _updateBoxesToOriginalPositions(Map<Offset, Box> boxes) {
    List<Box> updatedBoxes = <Box>[];
    for (final entry in boxes.entries) {
      final box = entry.value;
      if (box.location == entry.key) continue;

      final updatedBox = box.copyWith(location: entry.key);
      updatedBoxes.add(updatedBox);
    }
    boxesUpdated!(updatedBoxes);
  }

  void _updateBoxesToNewPositions(Map<Offset, Box> boxes, Offset localDelta) {
    List<Box> updatedBoxes = <Box>[];
    for (final entry in boxes.entries) {
      final box = entry.value;
      final newLocalLocation = entry.key + localDelta;
      final updatedBox = box.copyWith(location: newLocalLocation);
      updatedBoxes.add(updatedBox);
    }
    boxesUpdated!(updatedBoxes);
  }

  _snapToCell(Offset localLocation) => Offset(localLocation.dx.round().toDouble(), localLocation.dy.round().toDouble());

  _reset() {
    _boxRect = null;
    _globalStartLocation = null;
    _draggedRow = {};
    _draggedColumn = {};
  }
}
