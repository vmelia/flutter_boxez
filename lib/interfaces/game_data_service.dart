import 'dart:ui';

import '../types.dart';

abstract class GameDataService {
  Game get game;

  void initialize(Game game) {}
  
  void updateBoxes(List<Box> updates);
  void removeBoxes(List<Box> updates);

  // Returns a map of boxes that are in the same column/row as the index.
  // The mapped key is the original location of the box - so we can reset if required.
  Map<Offset, Box> getSelectedColumn(double index);
  Map<Offset, Box> getSelectedRow(double index);

  Iterable<List<Box>> getAllColumns();
  Iterable<List<Box>> getAllRows();
}
