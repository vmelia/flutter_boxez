import 'dart:ui';
import 'package:flutter_boxez/types.dart';

import '../interfaces.dart';

class DragServiceImpl extends DragService {
  DragServiceImpl(this.gameDataService);
  final GameDataService gameDataService;

  late double _boxWidth;
  late Offset? _globalStartLocation;
  late List<Box> _draggedRow;
  late List<Box> _draggedColumn;

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

  void _stillMovingBoxes(Offset globalLocation) {
    final draggingingHorizontally = _draggingHorizontally(globalLocation);
    final localDelta = _calculatelocalDelta(globalLocation, false);

    if (draggingingHorizontally) {
      _moveTemp(_draggedColumn, Location.zero());
      _moveTemp(_draggedRow, localDelta);
    } else {
      _moveTemp(_draggedRow, Location.zero());
      _moveTemp(_draggedColumn, localDelta);
    }
  }

  void _finishedMovingBoxes(Offset globalLocation) {
    final draggingingHorizontally = _draggingHorizontally(globalLocation);
    final localDelta = _calculatelocalDelta(globalLocation, true);

    if (draggingingHorizontally) {
      _moveFinal(_draggedRow, localDelta);
    } else {
      _moveFinal(_draggedColumn, localDelta);
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

  void _moveTemp(List<Box> boxes, Location delta) {
    for (final box in boxes) {
      box.moveTemp(delta);
    }

    moveMade!(false);
  }

  void _moveFinal(List<Box> boxes, Location delta) {
    for (final box in boxes) {
      box.moveByDelta(delta);
    }

    moveMade!(true);
  }

  _snapToCell(Location localLocation) => Location.fromInt(localLocation.dx.round(), localLocation.dy.round());

  _reset() {
    _globalStartLocation = null;
    _draggedRow = [];
    _draggedColumn = [];
  }
}
