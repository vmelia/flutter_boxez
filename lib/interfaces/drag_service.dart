import 'dart:ui';
import '../types.dart';

typedef BoxesUpdated = void Function(List<Box> updates, bool done);

abstract class DragService {
  void onPanStart(Offset dragLocation, Box box, double boxWidth);
  void onPanUpdate(Offset dragLocation);
  void onPanEnd(Offset dragLocation);

  late BoxesUpdated? boxesUpdated;
}
