import 'package:flutter/material.dart'; //ToDo: Remove.

import '../types.dart';

abstract class ScreenService {
  void initialize(Size screenSize) => _screenSize = screenSize; 
  late Size _screenSize;

  Size get screenSize => _screenSize;

  List<Widget> convertBoxesIntoWidgets(Game game); //ToDo: Move out of service.
  Box? getTappedBox(Offset globalPosition, Game game);
}
