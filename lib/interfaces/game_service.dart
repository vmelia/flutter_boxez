import '../types.dart';

abstract class GameService {
  void createGame();
  Game get game;

  int getValidColour(Location location, int proposedColour);
}
