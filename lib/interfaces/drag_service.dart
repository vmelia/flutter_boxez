import 'dart:ui';
import '../types.dart';

typedef BoxesUpdated = void Function(List<Box> updates);

abstract class DragService {
  void onPanStart(Offset dragLocation, Box box, Rect boxRect);
  void onPanUpdate(Offset dragLocation);
  void onPanEnd(Offset dragLocation);

  late BoxesUpdated? boxesUpdated;
}
