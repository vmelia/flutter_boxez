import 'dart:ui';

import '../interfaces.dart';
import '../types.dart';

class GameDataServiceImpl implements GameDataService {
  GameDataServiceImpl(this.gameProviderService);
  final GameProviderService gameProviderService;

  @override
  void updateBoxes(List<Box> updates) => updates.forEach(_updateBox);

  @override
  void removeBoxes(List<Box> updates) => gameProviderService.game.removeList(updates);

  @override
  Map<Offset, Box> getSelectedColumn(Offset location) {
    final map = <Offset, Box>{};
    for (final b in gameProviderService.game.boxes) {
      if (b.location.dx == location.dx) {
        map[b.location] = b;
      }
    }

    return map;
  }
  
  @override
  Map<Offset, Box> getSelectedRow(Offset location) {
    final map = <Offset, Box>{};
    for (final b in gameProviderService.game.boxes) {
      if (b.location.dy == location.dy) {
        map[b.location] = b;
      }
    }

    return map;
  }

  @override
  Map<double, List<Box>> getAllColumns() {
    final map = <double, List<Box>>{};
    for (final b in gameProviderService.game.boxes) {
      final col = map.putIfAbsent(b.location.dx, () => <Box>[]);
      col.add(b);
      col.sort((a, b) => a.location.dx.compareTo(b.location.dx));
    }

    return map;
  }

  @override
  Map<double, List<Box>> getAllRows() {
    final map = <double, List<Box>>{};
    for (final b in gameProviderService.game.boxes) {
      final row = map.putIfAbsent(b.location.dy, () => <Box>[]);
      row.add(b);
      row.sort((a, b) => a.location.dy.compareTo(b.location.dy));
    }

    return map;
  }

  void _updateBox(Box update) {
    final foundBox = gameProviderService.game.boxes.firstWhere((x) => x.index == update.index);
    gameProviderService.game.remove(foundBox);
    gameProviderService.game.add(update);
  }
}
