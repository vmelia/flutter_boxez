import 'dart:ui';

import '../types.dart';

typedef BoxesUpdated = void Function(List<Box> updates);

abstract class DragService {
  void onPanStart(Offset dragLocation, Location location, double boxWidth);
  void onPanUpdate(Offset dragLocation);
  void onPanEnd(Offset dragLocation);

  late BoxesUpdated? boxesMoving;
  late BoxesUpdated? boxesFinished;
}
