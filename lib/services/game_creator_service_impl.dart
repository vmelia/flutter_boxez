import 'dart:ui';

import '../helpers.dart';
import '../interfaces.dart';
import '../types.dart';

class GameCreatorServiceImpl implements GameCreatorService {
  GameCreatorServiceImpl(this.gameDataService, this.randomService);
  final GameDataService gameDataService;
  final RandomService randomService;

  @override
  Game createGame() => _createGame();

  Game _createGame() {
    gameDataService.createEmptyGame();
    int index = 0;
    for (var x = Constants.gridStart; x <= Constants.gridEnd; x++) {
      for (var y = Constants.gridStart; y <= Constants.gridEnd; y++) {
        final location = Offset(x, y);
        final proposedValue = randomService.value;
        final value = _getValidValue(location, proposedValue);

        gameDataService.add(Box(index: index, location: location, value: value));
        index++;
      }
    }

    return gameDataService.game;
  }

  // Game _createTestGame() {
  //   final game = Game()
  //   gameDataService.game.add(Box(index: 0, location: Offset(-1, -1), value: 0));
  //   gameDataService.game.add(Box(index: 1, location: Offset(-1, 0), value: 2));
  //   gameDataService.game.add(Box(index: 2, location: Offset(-1, 1), value: 0));
  //   gameDataService.game.add(Box(index: 3, location: Offset(0, -1), value: 2));
  //   gameDataService.game.add(Box(index: 4, location: Offset(0, 0), value: 4));
  //   gameDataService.game.add(Box(index: 5, location: Offset(0, 1), value: 2));
  //   gameDataService.game.add(Box(index: 6, location: Offset(1, -1), value: 0));
  //   gameDataService.game.add(Box(index: 7, location: Offset(1, 0), value: 2));
  //   gameDataService.game.add(Box(index: 8, location: Offset(1, 1), value: 0));
  //   return game;
  // }

  int _getValidValue(Offset location, int proposedValue) {
    for (var i = 0; i < Colours.count; i++) {
      final valueToCheck = (proposedValue + i) % Colours.count;
      if (_canPlaceValue(location, valueToCheck)) return valueToCheck;
    }

    return -1; // Error.
  }

  bool _canPlaceValue(Offset location, int valueToCheck) {
    if (_locationValueMatches(location.dx - 1, location.dy, valueToCheck)) return false;
    if (_locationValueMatches(location.dx + 1, location.dy, valueToCheck)) return false;
    if (_locationValueMatches(location.dx, location.dy - 1, valueToCheck)) return false;
    if (_locationValueMatches(location.dx, location.dy + 1, valueToCheck)) return false;

    return true;
  }

  bool _locationValueMatches(double x, double y, int valueToCheck) =>
      _locationExists(Offset(x, y)) && _containsTheSameValue(Offset(x, y), valueToCheck);

  bool _containsTheSameValue(Offset location, int valueToCheck) {
    final box = gameDataService.findByLocation(location);
    return box != null && box.value == valueToCheck;
  }

  bool _locationExists(Offset location) {
    if (location.dx < Constants.gridStart) return false;
    if (location.dy < Constants.gridStart) return false;
    if (location.dx > Constants.gridEnd) return false;
    if (location.dy > Constants.gridEnd) return false;

    return true;
  }
}
