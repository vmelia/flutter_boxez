import '../interfaces.dart';
import '../types.dart';

class GameDataServiceImpl implements GameDataService {
  late Game _game;

  @override
  Game get game => _game;

  @override
  void createEmptyGame() {
    _game = Game();
  }

  @override
  Box? findByLocation(Location location) {
    for (final box in _game.boxes) {
      if (box.location == location) return box;
    }

    return null;
  }

  @override
  void add(Box box) => _game.boxes.add(box);

  @override
  void remove(Box box) => _game.boxes.remove(box);

  @override
  void removeBoxes(List<Box> updates) => _game.boxes.removeWhere((box) => updates.contains(box));

  @override
  void updateBoxes(List<Box> updates) => updates.forEach(_updateBox);

  @override
  Map<Location, Box> getSelectedColumn(int index) {
    final map = <Location, Box>{};
    for (final b in game.boxes) {
      if (b.location.dx == index) {
        map[b.location] = b;
      }
    }

    return map;
  }

  @override
  Map<Location, Box> getSelectedRow(int index) {
    final map = <Location, Box>{};
    for (final b in game.boxes) {
      if (b.location.dy == index) {
        map[b.location] = b;
      }
    }

    return map;
  }

  @override
  Iterable<List<Box>> getAllColumns() {
    final map = <double, List<Box>>{};
    for (final b in game.boxes) {
      final col = map.putIfAbsent(b.location.dx, () => <Box>[]);
      col.add(b);
      col.sort((a, b) => a.location.dx.compareTo(b.location.dx));
    }

    return map.values;
  }

  @override
  Iterable<List<Box>> getAllRows() {
    final map = <double, List<Box>>{};
    for (final b in game.boxes) {
      final row = map.putIfAbsent(b.location.dy, () => <Box>[]);
      row.add(b);
      row.sort((a, b) => a.location.dy.compareTo(b.location.dy));
    }

    return map.values;
  }

  void _updateBox(Box update) {
    final foundBox = game.boxes.firstWhere((x) => x.index == update.index);
    remove(foundBox);
    add(update);
  }
}
