import 'dart:ui';

import '../interfaces.dart';
import '../types.dart';

class GameServiceImpl implements GameService {
  GameServiceImpl(this.randomService);
  final RandomService randomService;

  late Game _game;

  @override
  set game(Game newGame) => _game = newGame;

  @override
  Game get game => _game;

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
      final col = map.putIfAbsent(b.location.dx, () => <Box>[]);
      col.add(b);
      col.sort((a, b) => a.location.dx.compareTo(b.location.dx));
    }

    return map;
  }

  @override
  Map<double, List<Box>> getAllRows() {
    final map = <double, List<Box>>{};
    for (final b in _game.boxes) {
      final row = map.putIfAbsent(b.location.dy, () => <Box>[]);
      row.add(b);
      row.sort((a, b) => a.location.dy.compareTo(b.location.dy));
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
