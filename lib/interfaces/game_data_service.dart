import 'dart:ui';

import '../types.dart';

abstract class GameDataService {
  Game get game;

  void createNewGame();

  Box? findByLocation(Offset location);

  void add(Box box);
  void remove(Box box);

  // Matches indexes of existing boxes and replaces them with new ones.
  void updateBoxes(List<Box> updates);
  
  void removeBoxes(List<Box> updates);

  // Returns a map of boxes that are in the same column/row as the index.
  // The mapped key is the original location of the box - so we can reset if required.
  Map<Offset, Box> getSelectedColumn(double index);
  Map<Offset, Box> getSelectedRow(double index);

  Iterable<List<Box>> getAllColumns();
  Iterable<List<Box>> getAllRows();
}
