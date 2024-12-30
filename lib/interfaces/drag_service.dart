import 'dart:ui';
import '../types.dart';

abstract class DragService {
  void onPanStart(Box box, Offset globalPosition);
  void onPanUpdate(Offset globalPosition);
  void onPanEnd(Offset globalPosition);

  late VoidCallback? onChanged;
}
