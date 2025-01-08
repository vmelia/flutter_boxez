import '../helpers.dart';
import '../interfaces.dart';
import '../types.dart';

class GameCreatorServiceImpl extends GameCreatorService {
  GameCreatorServiceImpl(this.gameDataService, this.randomService);
  final GameDataService gameDataService;
  final RandomService randomService;

  @override
  void createGame() => _createGame();

  // void _createGame() {
  //   gameDataService.createEmptyGame();
  //   int index = 0;
  //   for (var x = Constants.gridStart; x <= Constants.gridEnd; x++) {
  //     for (var y = Constants.gridStart; y <= Constants.gridEnd; y++) {
  //       final location = Location.fromInt(x, y);
  //       final proposedValue = randomService.value;
  //       final value = _getValidValue(location, proposedValue);

  //       gameDataService.add(Box(index, location, value));
  //       index++;
  //     }
  //   }
  // }

  void _createGame() {
    gameDataService.createEmptyGame();
    gameDataService.add(Box(0, Location(-1, -1), 0));
    gameDataService.add(Box(1, Location(-1, 0), 2));
    gameDataService.add(Box(2, Location(-1, 1), 0));
    gameDataService.add(Box(3, Location(0, -1), 2));
    gameDataService.add(Box(4, Location(0, 0), 4));
    gameDataService.add(Box(5, Location(0, 1), 2));
    gameDataService.add(Box(6, Location(1, -1), 0));
    gameDataService.add(Box(7, Location(1, 0), 2));
    gameDataService.add(Box(8, Location(1, 1), 0));
  }

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
