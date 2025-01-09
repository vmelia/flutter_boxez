import '../types.dart';

abstract class GameDataService {
  Game get game;

  void createEmptyGame();

  Box? findByLocation(Location location);

  int getMaximumDxDyValue();

  void add(Box box);
  void remove(Box box);
  void markBoxesForRemoval(Set<Box> updates);

  // Returns a map of boxes that are in the same column/row as the index.
  // The mapped key is the original location of the box - so we can reset if required.
  List<Box> getSelectedColumn(int index);
  List<Box> getSelectedRow(int index);

  // Returns a list of all columns/row.
  Iterable<List<Box>> getAllColumns();
  Iterable<List<Box>> getAllRows();
}
