import 'package:flutter/material.dart';
import 'package:flutter_boxez/types.dart';
import 'package:get_it/get_it.dart';

import '../helpers.dart';
import '../interfaces.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({super.key, required this.game, required this.isDragging});
  final Game game;
  final bool isDragging;

  @override
  Widget build(BuildContext context) {
    final dragService = GetIt.I<DragService>();
    final widgets = WidgetHelper.convertBoxesIntoWidgets(game, context, isDragging);

    return Scaffold(
      body: GestureDetector(
        onPanStart: (details) {
          final box = WidgetHelper.getTappedBox(details.globalPosition, game, context);
          if (box != null) {
            final boxRect = WidgetHelper.getRect(box.location, context);
            dragService.onPanStart(details.globalPosition, box.location, boxRect.width);
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
