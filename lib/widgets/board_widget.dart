import 'package:flutter/material.dart';
import 'package:flutter_boxez/types.dart';
import 'package:get_it/get_it.dart';

import '../interfaces.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({super.key, required this.game});
  final Game game;

  @override
  Widget build(BuildContext context) {
    final dragService = GetIt.I<DragService>();
    final screenService = GetIt.I<ScreenService>();

    final widgets = screenService.convertBoxesIntoWidgets(game);

    return Scaffold(
      body: GestureDetector(
        onPanStart: (details) {
          dragService.onPanStart();
        },
        onPanUpdate: (details) {
          dragService.onPanUpdate();
        },
        onPanEnd: (details) {
          dragService.onPanEnd();
        },
        child: Stack(
          alignment: Alignment.center,
          children: widgets,
        ),
      ),
    );
  }
}
