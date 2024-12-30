import '../helpers/colours.dart';
import '../interfaces.dart';
import '../types.dart';

class GameServiceImpl implements GameService {
  GameServiceImpl(this.randomService);
  final RandomService randomService;

  final _game = Game();

  @override
  void createGame() {
    _game.boxes.clear();

    for (var x = -3; x <= 3; x++) {
      for (var y = -3; y <= 3; y++) {
        final location = Location(x, y);
        final proposedColour = randomService.colour;
        final colour = getValidColour(location, proposedColour);

        game.boxes.add(Box(location: location, colour: colour));
      }
    }
  }

  @override
  Game get game => _game;

  @override
  int getValidColour(Location location, int proposedColour) {
    for (var i = 0; i < Colours.count; i++) {
      final colourToCheck = (proposedColour + i) % Colours.count;
      if (_canPlaceColour(location, colourToCheck)) return colourToCheck;
    }

    return -1; // Error.
  }

  bool _canPlaceColour(Location location, int colourToCheck) {
    if (_locationColourMatches(location.x - 1, location.y, colourToCheck)) return false;
    if (_locationColourMatches(location.x + 1, location.y, colourToCheck)) return false;
    if (_locationColourMatches(location.x, location.y - 1, colourToCheck)) return false;
    if (_locationColourMatches(location.x, location.y + 1, colourToCheck)) return false;

    return true;
  }

  bool _locationColourMatches(int x, int y, int colourToCheck) =>
      _locationExists(Location(x, y)) && _isTheSameColour(Location(x, y), colourToCheck);

  bool _locationExists(Location location) {
    if (location.x < Constants.gridStart) return false;
    if (location.y < Constants.gridStart) return false;
    if (location.x > Constants.gridEnd) return false;
    if (location.x > Constants.gridEnd) return false;

    return true;
  }

  bool _isTheSameColour(Location location, int colourToCheck) {
    final box = _findByLocation(location);
    return box != null && box.colour == colourToCheck;
  }

  Box? _findByLocation(Location location) {
    for (final box in _game.boxes) {
      if (box.location == location) return box;
    }

    return null;
  }
}
