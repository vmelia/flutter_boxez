import 'dart:ui';

import '../interfaces.dart';
import '../types.dart';

class GameDataServiceImpl implements GameDataService {
  GameDataServiceImpl(this.randomService);
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
}
