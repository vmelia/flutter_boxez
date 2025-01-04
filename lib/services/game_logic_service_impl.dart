import '../interfaces.dart';
import '../types.dart';

class GameLogicServiceImpl extends GameLogicService {
  GameLogicServiceImpl(this.gameCreatorService, this.gameDataService);
  final GameCreatorService gameCreatorService;
  final GameDataService gameDataService;

  @override
  Game get game => gameCreatorService.game;

  @override
  bool removeContiguousBoxes() =>
      _removeContiguousBoxesInColumnsOrRows(gameDataService.getAllRows().values.toList()) ||
      _removeContiguousBoxesInColumnsOrRows(gameDataService.getAllColumns().values.toList());

  bool _removeContiguousBoxesInColumnsOrRows(List<List<Box>> columnsOrRows) {
    final boxesToRemove = <Box>[];

    for (final columnsOrRow in columnsOrRows) {
      Box? lastBox;
      List<Box> run = <Box>[];
      for (final b in columnsOrRow) {
        if (lastBox == null || lastBox.colour != b.colour) {
          // Start new run.
          if (run.length >= 3) {
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

    if (boxesToRemove.isNotEmpty) {
      gameDataService.removeBoxes(boxesToRemove);
    }

    return boxesToRemove.isNotEmpty;
  }
}
