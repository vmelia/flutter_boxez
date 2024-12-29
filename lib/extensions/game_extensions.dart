import 'package:flutter/material.dart';

import '../extensions.dart';
import '../types.dart';
import '../widgets.dart';

extension GameExtensions on Game {
  List<Widget> convertBoxesIntoWidgets(Size screenSize)=> boxes
      .map(
        (box) => Positioned.fromRect(
          rect: box.location.getRect(screenSize),
          child: BoxWidget(box: box),
        ),
      )
      .toList();
      
  Rect getRect(Location location, Size screenSize) {
    final boxWidth = screenSize.shortestSide / Constants.gridSize;
    final x = screenSize.width / 2 + location.x * boxWidth;
    final y = screenSize.height / 2 + location.y * boxWidth;

    return Rect.fromCenter(center: Offset(x, y), width: boxWidth, height: boxWidth);
  }

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
    final box = grid[location];
    return box != null && box.colour == colourToCheck;
  }
}
