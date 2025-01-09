import '../interfaces.dart';
import '../types.dart';

class GameLogicServiceImpl extends GameLogicService {
  GameLogicServiceImpl(this.gameDataService, this.loggerService);
  final GameDataService gameDataService;
  final LoggerService loggerService;

  @override
  Set<Box> removeContiguousBoxes() {
    Set<Box> boxesToRemove = <Box>{};
    final columnBoxes = _removeContiguousBoxesInColumnsOrRows(gameDataService.getAllColumns());
    boxesToRemove.addAll(columnBoxes);
    final rowBoxes = _removeContiguousBoxesInColumnsOrRows(gameDataService.getAllRows());
    boxesToRemove.addAll(rowBoxes);

    if (boxesToRemove.isNotEmpty) {
      gameDataService.removeBoxes(boxesToRemove);
    }

    return boxesToRemove;
  }

  @override
  bool collapseToCentre() {
    // Get potential box locations.
    final gridLocations = _getGridLocations();
    bool anyChanges = false;
    for (final pos in gridLocations) {
      if (pos.x > 0 || pos.y > 0) {
        final changed = _checkTwelveLocations(pos);
        anyChanges = anyChanges || changed;
      }
    }

    return anyChanges;
  }

  // removeContiguousBoxes
  Set<Box> _removeContiguousBoxesInColumnsOrRows(Iterable<List<Box>> allColumnsOrRows) {
    final boxesToRemove = <Box>{};
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
  List<Pos> _getGridLocations() {
    final max = gameDataService.getMaximumDxDyValue();
    loggerService.info('_getGridLocations() - 0..$max');

    final gridLocations = <Pos>[];
    for (int x = 0; x <= max; x++) {
      for (int y = 0; y <= max; y++) {
        gridLocations.add(Pos(x, y));
      }
    }

    gridLocations.sort((a, b) => (a.x * a.y).abs().compareTo((b.x * b.y).abs()));
    return gridLocations;
  }

  bool _checkTwelveLocations(Pos pos) {
    if (pos.x == 0 && pos.y == 0) return false; // Cannot improve.
    //loggerService.info('_checkTwelveLocations(${pos.x}, ${pos.y})');

    final ne = _checkThreeLocation(Pos(pos.x, pos.y));
    final se = _checkThreeLocation(Pos(pos.x, -pos.y));
    final sw = _checkThreeLocation(Pos(-pos.x, -pos.y));
    final nw = _checkThreeLocation(Pos(-pos.x, pos.y));

    return ne || se || sw || nw;
  }

  bool _checkThreeLocation(Pos pos) {
    //loggerService.info('_checkThreeLocation(${pos.x}, ${pos.y})');
    if (pos.x == 0 && pos.y == 0) return false; // Cannot improve.

    final box = gameDataService.findByLocation(Location.fromInt(pos.x, pos.y));
    if (box == null) return false;

    loggerService.info('Box(${box.location.dx}, ${box.location.dy} = ${box.index}');
    Set<Pos> targetLocations = <Pos>{};
    if (pos.x != 0 && pos.y != 0) {
      targetLocations.add(Pos(_decrement(pos.x), _decrement(pos.y)));
    }
    if (pos.x != 0) {
      targetLocations.add(Pos(_decrement(pos.x), pos.y));
    }
    if (pos.y != 0) {
      targetLocations.add(Pos(pos.x, _decrement(pos.y)));
    }

    for (final target in targetLocations) {
      final targetLocation = Location.fromInt(target.x, target.y);
      loggerService.info('  Checking (${targetLocation.dx}, ${targetLocation.dy})');
      final existingBox = gameDataService.findByLocation(targetLocation);

      if (existingBox != null) {
        loggerService.info('  Already occupied: (${targetLocation.dx}, ${targetLocation.dy})');
        continue; // Cannot move here - it's already occupied.
      }

      box.moveAbsolute(targetLocation);
      return true;
    }

    return false;
  }

  int _decrement(int i) {
    if (i > 0) return i - 1;
    if (i < 0) return i + 1;

    return i;
  }
}
