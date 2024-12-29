import 'package:flutter/material.dart';

abstract class DragService {
  void initialize(Size screenSize);
  void onPanStart(DragStartDetails details);
  void onPanUpdate(DragUpdateDetails details);
  void onPanEnd(DragEndDetails details);
}
