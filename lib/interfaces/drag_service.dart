import 'dart:ui';
import '../types.dart';

typedef BoxUpdated = void Function(Box box);

abstract class DragService {
  void onPanStart(Offset dragStartLocation, Box box, Rect boxRect);
  void onPanUpdate(Offset dragCurrentLocation);
  void onPanEnd(Offset dragEndLocation);

  late BoxUpdated? boxUpdated;
}
