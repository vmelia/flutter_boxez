import 'package:flutter/material.dart';

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
  MaterialColor getValidColour(Location location, MaterialColor proposedColour) {
    for (var i = 0; i < Constants.colours.length; i++) {
      final colourToCheck = _getColourFromOffset(proposedColour, i);
      if (_canPlaceColour(location, colourToCheck)) return colourToCheck;
    }

    return Colors.pink; // Error.
  }

  MaterialColor _getColourFromOffset(MaterialColor proposedColour, int offset) {
    final indexToCheck = Constants.colours.indexOf(proposedColour) + offset;
    return Constants.colours[indexToCheck % Constants.colours.length];
  }

  bool _canPlaceColour(Location location, MaterialColor colourToCheck) {
    if (_locationColourMatches(location.x - 1, location.y, colourToCheck)) return false;
    if (_locationColourMatches(location.x + 1, location.y, colourToCheck)) return false;
    if (_locationColourMatches(location.x, location.y - 1, colourToCheck)) return false;
    if (_locationColourMatches(location.x, location.y + 1, colourToCheck)) return false;

    return true;
  }

  bool _locationColourMatches(int x, int y, MaterialColor colourToCheck) =>
      _locationExists(Location(x, y)) && _isTheSameColour(Location(x, y), colourToCheck);

  bool _locationExists(Location location) {
    if (location.x < Constants.gridStart) return false;
    if (location.y < Constants.gridStart) return false;
    if (location.x > Constants.gridEnd) return false;
    if (location.x > Constants.gridEnd) return false;

    return true;
  }

  bool _isTheSameColour(Location location, MaterialColor colourToCheck) {
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
