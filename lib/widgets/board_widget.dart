import 'package:flutter/material.dart';
import 'package:flutter_boxez/types.dart';
import 'package:get_it/get_it.dart';

import '../helpers.dart';
import '../interfaces.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({super.key, required this.game});
  final Game game;

  @override
  Widget build(BuildContext context) {
    final dragService = GetIt.I<DragService>();
    final gameService = GetIt.I<GameService>();

    final widgets = WidgetHelper.convertBoxesIntoWidgets(game, context);

    return Scaffold(
      body: GestureDetector(
        onPanStart: (details) {
          final box = WidgetHelper.getTappedBox(details.globalPosition, gameService.game, context);
          if (box != null) {
            final boxRect = WidgetHelper.getRect(box.location, context);
            dragService.onPanStart(details.globalPosition, box, boxRect);
          }
        },
        onPanUpdate: (details) {
          dragService.onPanUpdate(details.globalPosition);
        },
        onPanEnd: (details) {
          dragService.onPanEnd(details.globalPosition);
        },
        child: Stack(
          alignment: Alignment.center,
          children: widgets,
        ),
      ),
    );
  }
}
