import 'package:flutter/material.dart';

import '../types.dart';

extension GameExtensions on Game {
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

  bool _locationColourMatches(int x, int y, MaterialColor colourToCheck) {
    final location = Location(x, y);
    return _locationExists(Location(x, y)) && _isTheSameColour(location, colourToCheck);
  }

  bool _locationExists(Location location) {
    if (location.x < Constants.gridStart) return false;
    if (location.y < Constants.gridStart) return false;
    if (location.x > Constants.gridEnd) return false;
    if (location.x > Constants.gridEnd) return false;

    return true;
  }

  bool _isTheSameColour(Location location, MaterialColor colourToCheck) {
    final colour = grid[location];
    return colour != null && colour == colourToCheck;
  }
}
