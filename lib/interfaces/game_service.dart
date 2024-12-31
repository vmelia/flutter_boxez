import 'dart:ui';

import '../types.dart';

abstract class GameService {
  void createGame();
  Game get game;

  int getValidColour(Offset location, int proposedColour);
  void updateBoxes(List<Box> updates);
}
