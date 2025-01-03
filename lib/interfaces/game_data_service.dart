import 'dart:ui';

import '../types.dart';

abstract class GameDataService {
  set game(Game game);
  Game get game;

  void updateBoxes(List<Box> updates);

  Map<Offset, Box> getSelectedRow(Box box);
  Map<Offset, Box> getSelectedColumn(Box box);

  Map<double, List<Box>> getAllRows();
  Map<double, List<Box>> getAllColumns();
}
