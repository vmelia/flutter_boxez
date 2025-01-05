import 'dart:math';

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
  void plugGaps() {
    final clonedGame = Game.clone(gameDataService.game);  //TODO: Needed?
    final distSortedBoxes = clonedGame.boxes;
    distSortedBoxes.sort((a, b) => a.location.distanceSquared.compareTo(b.location.distanceSquared));

    final updatedBoxes = <Box>{};
    for (final box in distSortedBoxes) {
      final possibleMoves = <double>[];
      Location centreOffset = Location.zero() - box.location;
      for (final cardinal in Constants.cardinals) {
        final angleDelta = (cardinal - centreOffset.direction).abs();
        if (angleDelta < pi / 3) {
          possibleMoves.add(angleDelta);
        }
      }

      for (final move in possibleMoves) {
        final newLocation = box.location + Location.fromDirection(move);
        if (gameDataService.findByLocation(newLocation) == null) {
          final updatedBox = box.copyWith(location: newLocation);
          updatedBoxes.add(updatedBox);
        }
      }
    }

    if (updatedBoxes.isNotEmpty) {
      boxesMoving!(updatedBoxes);
    }
  }

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
}
