import 'dart:ui';
import '../types.dart';

abstract class DragService {
  void onPanStart(Box box, Offset position);
  void onPanUpdate(Offset position);
  void onPanEnd(Offset position);
}
