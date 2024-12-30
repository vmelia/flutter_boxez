import 'package:flutter/material.dart';
import 'package:flutter_boxez/types.dart';
import 'package:get_it/get_it.dart';

import '../extensions.dart';
import '../interfaces.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({super.key, required this.game});
  final Game game;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final dragService = GetIt.I<DragService>();

    final widgets = screenSize.convertBoxesIntoWidgets(game);

    return Scaffold(
      body: GestureDetector(
        onPanStart: (details) {
          dragService.onPanStart(details);
        },
        onPanUpdate: (details) {
          dragService.onPanUpdate(details);
        },
        onPanEnd: (details) {
          dragService.onPanEnd(details);
        },
        child: Stack(
          alignment: Alignment.center,
          children: widgets,
        ),
      ),
    );
  }
}
