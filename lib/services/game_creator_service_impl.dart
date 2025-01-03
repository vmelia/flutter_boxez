import 'dart:ui';

import '../helpers.dart';
import '../interfaces.dart';
import '../types.dart';

class GameCreatorServiceImpl implements GameCreatorService {
  GameCreatorServiceImpl(this.randomService);
  final RandomService randomService;

  final _game = Game();

  @override
  void createGame() {
    _game.boxes.clear();

    int index = 0;
    for (var x = Constants.gridStart; x <= Constants.gridEnd; x++) {
      for (var y = Constants.gridStart; y <= Constants.gridEnd; y++) {
        final location = Offset(x, y);
        final proposedColour = randomService.colour;
        final colour = _getValidColour(location, proposedColour);

        game.boxes.add(Box(index: index, location: location, colour: colour));
        index++;
      }
    }
  }

  @override
  Game get game => _game;

  int _getValidColour(Offset location, int proposedColour) {
    for (var i = 0; i < Colours.count; i++) {
      final colourToCheck = (proposedColour + i) % Colours.count;
      if (_canPlaceColour(location, colourToCheck)) return colourToCheck;
    }

    return -1; // Error.
  }

  bool _canPlaceColour(Offset location, int colourToCheck) {
    if (_locationColourMatches(location.dx - 1, location.dy, colourToCheck)) return false;
    if (_locationColourMatches(location.dx + 1, location.dy, colourToCheck)) return false;
    if (_locationColourMatches(location.dx, location.dy - 1, colourToCheck)) return false;
    if (_locationColourMatches(location.dx, location.dy + 1, colourToCheck)) return false;

    return true;
  }

  bool _locationColourMatches(double x, double y, int colourToCheck) =>
      _locationExists(Offset(x, y)) && _isTheSameColour(Offset(x, y), colourToCheck);

  bool _locationExists(Offset location) {
    if (location.dx < Constants.gridStart) return false;
    if (location.dy < Constants.gridStart) return false;
    if (location.dx > Constants.gridEnd) return false;
    if (location.dy > Constants.gridEnd) return false;

    return true;
  }

  bool _isTheSameColour(Offset location, int colourToCheck) {
    final box = _findByLocation(location);
    return box != null && box.colour == colourToCheck;
  }

  Box? _findByLocation(Offset location) {
    for (final box in _game.boxes) {
      if (box.location == location) return box;
    }

    return null;
  }
}
