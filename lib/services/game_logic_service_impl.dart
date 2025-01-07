import '../interfaces.dart';
import '../types.dart';

class GameLogicServiceImpl extends GameLogicService {
  GameLogicServiceImpl(this.gameDataService);
  final GameDataService gameDataService;

  @override
  bool removeContiguousBoxes() {
    Set<Box> boxesToRemove = <Box>{};
    final columnBoxes = _removeContiguousBoxesInColumnsOrRows(gameDataService.getAllColumns());
    boxesToRemove.addAll(columnBoxes);
    final rowBoxes = _removeContiguousBoxesInColumnsOrRows(gameDataService.getAllRows());
    boxesToRemove.addAll(rowBoxes);

    if (boxesToRemove.isNotEmpty) {
      gameDataService.removeBoxes(boxesToRemove);
      return true;
    }

    return false;
  }

  @override
  bool collapseToCentre() {
    Set<Box> boxesToUpdate = <Box>{};
    for (int x = 0; x < 10; x++) {
      // Use calculated max values.
      for (int y = 0; x < 10; y++) {
        boxesToUpdate.addAll(_checkFourLocations(Pos(x, y)));
      }
    }
    if (boxesToUpdate.isNotEmpty) {
      gameDataService.updateBoxes(boxesToUpdate);
      return true;
    }

    return false;
  }

  // removeContiguousBoxes
  List<Box> _removeContiguousBoxesInColumnsOrRows(Iterable<List<Box>> allColumnsOrRows) {
    final boxesToRemove = <Box>[];
    for (final columnOrRow in allColumnsOrRows) {
      Box? lastBox;
      List<Box> run = <Box>[];
      for (final b in columnOrRow) {
        if (lastBox == null || lastBox.value != b.value || !_boxesTouch(lastBox, b)) {
          // Start new run.
          if (run.length >= Constants.matchesRequired) {
            boxesToRemove.addAll(run);
          }

          run.clear();
          run.add(b);
        } else {
          // Continue run.
          run.add(b);
        }

        lastBox = b;
      }

      if (run.length >= Constants.matchesRequired) {
        boxesToRemove.addAll(run);
      }
    }

    return boxesToRemove;
  }

  bool _boxesTouch(Box lastBox, Box b) {
    if ((lastBox.location.dx - b.location.dx).abs() > 1) return false;
    if ((lastBox.location.dy - b.location.dy).abs() > 1) return false;

    return true;
  }

  // collapseToCentre
  List<Box> _checkFourLocations(Pos pos) {
    List<Box> boxesToUpdate = <Box>[];

    final ne = _checkOneLocation(Pos(pos.x, pos.y));
    if (ne != null) boxesToUpdate.add(ne);

    final se = _checkOneLocation(Pos(pos.x, -pos.y));
    if (se != null) boxesToUpdate.add(se);

    final sw = _checkOneLocation(Pos(-pos.x, pos.y));
    if (sw != null) boxesToUpdate.add(sw);

    final nw = _checkOneLocation(Pos(-pos.x, pos.y));
    if (nw != null) boxesToUpdate.add(nw);

    return boxesToUpdate;
  }

  Box? _checkOneLocation(Pos pos) {
    if (pos.x == 0 && pos.y == 0) return null; // cannot improve.

    final box = gameDataService.findByLocation(Location.fromInt(pos.x, pos.y));
    if (box == null) return null;

    Set<Pos> targetLocations = <Pos>{};
    targetLocations.add(Pos(pos.x + _increment(pos.x), pos.y + _increment(pos.y)));
    targetLocations.add(Pos(pos.x + _increment(pos.x), pos.y));
    targetLocations.add(Pos(pos.x, pos.y + _increment(pos.y)));

    for (final target in targetLocations) {
      final existingBox = gameDataService.findByLocation(Location.fromInt(target.x, target.y));
      if (existingBox != null) continue; // cannot move here - it's already full.

      final newBox = box.copyWith(location: Location.fromInt(target.x, target.y));
      return newBox;
    }

    return null;
  }

  int _increment(int i) {
    if (i > 0) return -1;
    if (i < 0) return 1;
    return 0;
  }
}
