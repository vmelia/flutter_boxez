import 'dart:ui';

import '../types.dart';

abstract class GameDataService {
  void updateBoxes(List<Box> updates);
  void removeBoxes(List<Box> updates);

  Map<Offset, Box> getSelectedColumn(double index);
  Map<Offset, Box> getSelectedRow(double index);

  Map<double, List<Box>> getAllColumns();
  Map<double, List<Box>> getAllRows();
}
