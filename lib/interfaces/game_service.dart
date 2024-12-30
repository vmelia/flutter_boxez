import 'package:flutter/material.dart';

import '../types.dart';

abstract class GameService {
  void createGame();
  Game get game;

  MaterialColor getValidColour(Location location, MaterialColor proposedColour);  //ToDo: Move out of service.
}
