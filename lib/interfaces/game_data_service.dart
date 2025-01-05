import '../types.dart';

abstract class GameDataService {
  Game get game;

  void createEmptyGame();

  Box? findByLocation(Location location);

  void add(Box box);
  void remove(Box box);
  void removeBoxes(List<Box> updates);

  // Update boxes functionality.
  // Note: Because Box is immutable, we have to remove old versions and add new ones (based on index).
  void updateBoxes(List<Box> updates);

  // Returns a map of boxes that are in the same column/row as the index.
  // The mapped key is the original location of the box - so we can reset if required.
  Map<Location, Box> getSelectedColumn(int index);
  Map<Location, Box> getSelectedRow(int index);

  // Returns a list of all columns/row.
  Iterable<List<Box>> getAllColumns();
  Iterable<List<Box>> getAllRows();
}
