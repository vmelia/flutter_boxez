import 'package:flutter/material.dart';  //ToDo: Remove.

import '../types.dart';

abstract class ScreenService {
  void initialize(BuildContext context);
  Size get screenSize;

  List<Widget> convertBoxesIntoWidgets(Game game);  //ToDo: Move out of service.
  Box? getTappedBox(Offset globalPosition, Game game);
}
