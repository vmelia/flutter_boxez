import 'dart:ui';

import '../types.dart';

abstract class GameDataService {
  void updateBoxes(List<Box> updates);
  void removeBoxes(List<Box> updates);

  Map<Offset, Box> getSelectedRow(Offset location);
  Map<Offset, Box> getSelectedColumn(Offset location);

  Map<double, List<Box>> getAllRows();
  Map<double, List<Box>> getAllColumns();
}
