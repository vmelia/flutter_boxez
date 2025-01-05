import 'dart:ui';

import '../types.dart';

abstract class DragService {
  void onPanStart(Offset dragLocation, Location location, double boxWidth);
  void onPanUpdate(Offset dragLocation);
  void onPanEnd(Offset dragLocation);

  BoxesUpdated? boxesMoving;
  BoxesUpdated? boxesFinished;
}
