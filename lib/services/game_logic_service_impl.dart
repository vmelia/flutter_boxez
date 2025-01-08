import '../interfaces.dart';
import '../types.dart';

class GameLogicServiceImpl extends GameLogicService {
  GameLogicServiceImpl(this.gameDataService, this.loggerService);
  final GameDataService gameDataService;
  final LoggerService loggerService;

  @override
  bool removeContiguousBoxes() {
    //loggerService.info('removeContiguousBoxes()');
    Set<Box> boxesToRemove = <Box>{};
    final columnBoxes = _removeContiguousBoxesInColumnsOrRows(gameDataService.getAllColumns());
    boxesToRemove.addAll(columnBoxes);
    final rowBoxes = _removeContiguousBoxesInColumnsOrRows(gameDataService.getAllRows());
    boxesToRemove.addAll(rowBoxes);

    if (boxesToRemove.isEmpty) return false;

    gameDataService.removeBoxes(boxesToRemove);
    return true;
  }

  @override
  bool collapseToCentre() {
    //loggerService.info('collapseToCentre()');
    final max = gameDataService.getMaximumDxDyValue();
    loggerService.info('collapseToCentre() - 0..$max');
    bool anyChanges = false;
    for (int x = 0; x <= max; x++) {
      for (int y = 0; y <= max; y++) {
        if (x > 0 || y > 0) {
          final changed = _checkTwelveLocations(Pos(x, y));
          anyChanges = anyChanges || changed;
        }
      }
    }

    return anyChanges;
  }

  // removeContiguousBoxes
  Set<Box> _removeContiguousBoxesInColumnsOrRows(Iterable<List<Box>> allColumnsOrRows) {
    //loggerService.info('_removeContiguousBoxesInColumnsOrRows()');
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
