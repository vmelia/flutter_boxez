import '../interfaces.dart';
import '../types.dart';

class GameDataServiceImpl extends GameDataService {
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
  int getMaximumDxDyValue() {
    var max = 0;
    for (final box in _game.boxes) {
      if (box.location.dx.toInt().abs() > max) max = box.location.dx.toInt().abs();
      if (box.location.dy.toInt().abs() > max) max = box.location.dy.toInt().abs();
    }

    return max;
  }

  @override
  void add(Box box) => _game.boxes.add(box);

  @override
  void markBoxesForRemoval(Set<Box> updates) {
    _game.boxes.removeWhere((box) => updates.contains(box));
  }

  @override
  List<Box> getSelectedColumn(int index) {
    final list = <Box>[];
    for (final b in game.boxes) {
      if (b.location.dx == index) {
        list.add(b);
      }
    }

    return list;
  }

  @override
  List<Box> getSelectedRow(int index) {
    final list = <Box>[];
    for (final b in game.boxes) {
      if (b.location.dy == index) {
        list.add(b);
      }
    }

    return list;
  }

  @override
  Iterable<List<Box>> getAllColumns() {
    final map = <double, List<Box>>{};
    for (final b in game.boxes) {
      final col = map.putIfAbsent(b.location.dx, () => <Box>[]);
      col.add(b);
      col.sort((a, b) => a.location.dy.compareTo(b.location.dy));
    }

    return map.values;
  }

  @override
  Iterable<List<Box>> getAllRows() {
    final map = <double, List<Box>>{};
    for (final b in game.boxes) {
      final row = map.putIfAbsent(b.location.dy, () => <Box>[]);
      row.add(b);
      row.sort((a, b) => a.location.dx.compareTo(b.location.dx));
    }

    return map.values;
  }
}
