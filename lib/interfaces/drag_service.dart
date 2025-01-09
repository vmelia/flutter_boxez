import 'dart:ui';

import '../types.dart';

abstract class DragService {
  void onPanStart(Offset globalLocation, Location location, double boxWidth);
  void onPanUpdate(Offset globalLocation);
  void onPanEnd(Offset globalLocation);

  MoveMade? moveMade;
}
