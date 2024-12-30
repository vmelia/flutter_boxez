import 'package:flutter/material.dart';  //ToDo: Remove.

abstract class DragService {
  void onPanStart(DragStartDetails details);
  void onPanUpdate(DragUpdateDetails details);
  void onPanEnd(DragEndDetails details);
}
