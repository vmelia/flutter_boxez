import 'dart:ui';

import '../types.dart';

abstract class GameDataService {
  void updateBoxes(List<Box> updates);
  void removeBoxes(List<Box> updates);

  Map<Offset, Box> getSelectedColumn(Offset location);
  Map<Offset, Box> getSelectedRow(Offset location);

  Map<double, List<Box>> getAllColumns();
  Map<double, List<Box>> getAllRows();
}
