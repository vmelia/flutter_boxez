import '../helpers.dart';
import '../interfaces.dart';
import '../types.dart';

class GameCreatorServiceImpl extends GameCreatorService {
  GameCreatorServiceImpl(this.gameDataService, this.randomService);
  final GameDataService gameDataService;
  final RandomService randomService;

  @override
  void createGame() => _createGame();

  void _createGame() {
    gameDataService.createEmptyGame();
    int index = 0;
    for (var x = Constants.gridStart; x <= Constants.gridEnd; x++) {
      for (var y = Constants.gridStart; y <= Constants.gridEnd; y++) {
        final location = Location.fromInt(x, y);
        final proposedValue = randomService.value;
        final value = _getValidValue(location, proposedValue);

        gameDataService.add(Box(index: index, location: location, value: value));
        index++;
      }
    }
  }

  // void _createGame() {
  //   gameDataService.createEmptyGame();
  //   gameDataService.add(Box(index: 0, location: Location(-1, -1), value: 0));
  //   gameDataService.add(Box(index: 1, location: Location(-1, 0), value: 2));
  //   gameDataService.add(Box(index: 2, location: Location(-1, 1), value: 0));
  //   gameDataService.add(Box(index: 3, location: Location(0, -1), value: 2));
  //   gameDataService.add(Box(index: 4, location: Location(0, 0), value: 4));
  //   gameDataService.add(Box(index: 5, location: Location(0, 1), value: 2));
  //   gameDataService.add(Box(index: 6, location: Location(1, -1), value: 0));
  //   gameDataService.add(Box(index: 7, location: Location(1, 0), value: 2));
  //   gameDataService.add(Box(index: 8, location: Location(1, 1), value: 0));
  // }

  int _getValidValue(Location location, int proposedValue) {
    for (var i = 0; i < Colours.count; i++) {
      final valueToCheck = (proposedValue + i) % Colours.count;
      if (_canPlaceValue(location, valueToCheck)) return valueToCheck;
    }

    return -1; // Error.
  }

  bool _canPlaceValue(Location location, int valueToCheck) {
    if (_locationValueMatches(location.dx - 1, location.dy, valueToCheck)) return false;
    if (_locationValueMatches(location.dx + 1, location.dy, valueToCheck)) return false;
    if (_locationValueMatches(location.dx, location.dy - 1, valueToCheck)) return false;
    if (_locationValueMatches(location.dx, location.dy + 1, valueToCheck)) return false;

    return true;
  }

  bool _locationValueMatches(double dx, double dy, int valueToCheck) =>
      _locationExists(Location(dx, dy)) && _containsTheSameValue(Location(dx, dy), valueToCheck);

  bool _containsTheSameValue(Location location, int valueToCheck) {
    final box = gameDataService.findByLocation(location);
    return box != null && box.value == valueToCheck;
  }

  bool _locationExists(Location location) {
    if (location.dx < Constants.gridStart) return false;
    if (location.dy < Constants.gridStart) return false;
    if (location.dx > Constants.gridEnd) return false;
    if (location.dy > Constants.gridEnd) return false;

    return true;
  }
}
