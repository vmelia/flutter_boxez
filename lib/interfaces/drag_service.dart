import 'dart:ui';
import '../types.dart';

typedef BoxesUpdated = void Function(List<Box> updates);

abstract class DragService {
  void onPanStart(Offset dragStartLocation, Box box, Rect boxRect);
  void onPanUpdate(Offset dragCurrentLocation);
  void onPanEnd(Offset dragEndLocation);

  late BoxesUpdated? boxesUpdated;
}
