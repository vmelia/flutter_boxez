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

      if (run.length >= 3) {
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
