import 'package:flutter_boxez/types.dart';

import '../interfaces.dart';

class DragServiceImpl implements DragService {
  DragServiceImpl(this.gameService, this.screenService);
  final GameService gameService;
  final ScreenService screenService;

  late Box? draggedBox;

  @override
  void onPanStart() {
    // draggedBox = null;

    // final box = screenService.getTappedBox(details.globalPosition, gameService.game);
    // if (box == null) return;

    // draggedBox = box;
  }

  @override
  void onPanUpdate() {}

  @override
  void onPanEnd() {}
}
