import 'dart:ui';

import '../types.dart';

abstract class GameService {
  void createGame();
  Game get game;

  int getValidColour(Offset location, int proposedColour);
  void updateBoxes(List<Box> updates);

  Map<Offset, Box> getSelectedRow(Box box);
  Map<Offset, Box> getSelectedColumn(Box box);

  Map<double, List<Box>> getAllRows();
  Map<double, List<Box>> getAllColumns();
}
