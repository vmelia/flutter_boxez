import 'dart:ui';

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

    int index = 0;
    for (var x = Constants.gridStart; x <= Constants.gridEnd; x++) {
      for (var y = Constants.gridStart; y <= Constants.gridEnd; y++) {
        final location = Offset(x, y);
        final proposedColour = randomService.colour;
        final colour = getValidColour(location, proposedColour);

        game.boxes.add(Box(index: index, location: location, colour: colour));
        index++;
      }
    }
  }

  @override
  Game get game => _game;

  @override
  int getValidColour(Offset location, int proposedColour) {
    for (var i = 0; i < Colours.count; i++) {
      final colourToCheck = (proposedColour + i) % Colours.count;
      if (_canPlaceColour(location, colourToCheck)) return colourToCheck;
    }

    return -1; // Error.
  }

  @override
  void updateBoxes(List<Box> updates) => _game.updateBoxes(updates);

  @override
  Map<Offset, Box> getSelectedRow(Box box) {
    final map = <Offset, Box>{};
    for (final b in _game.boxes) {
      if (b.location.dy == box.location.dy) {
        map[b.location] = b;
      }
    }

    return map;
  }

  @override
  Map<Offset, Box> getSelectedColumn(Box box) {
    final map = <Offset, Box>{};
    for (final b in _game.boxes) {
      if (b.location.dx == box.location.dx) {
        map[b.location] = b;
      }
    }

    return map;
  }
  
  @override
  Map<double, List<Box>> getAllColumns() {
    final map = <double, List<Box>>{};
    for (final b in _game.boxes) {
      if (!map.containsKey(b.location.dx)) {
        map[b.location.dx] = <Box>[];
      }
      map[b.location.dx]!.add(b);
      map[b.location.dx]!.sort((a, b) => a.location.dx.compareTo(b.location.dx));
    }

    return map;
  }

  @override
  Map<double, List<Box>> getAllRows() {
    final map = <double, List<Box>>{};
    for (final b in _game.boxes) {
      if (!map.containsKey(b.location.dy)) {
        map[b.location.dy] = <Box>[];
      }
      map[b.location.dy]!.add(b);
      map[b.location.dy]!.sort((a, b) => a.location.dy.compareTo(b.location.dy));
    }

    return map;
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
