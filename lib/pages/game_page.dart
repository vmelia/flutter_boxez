import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../interfaces.dart';
import '../widgets.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenService = GetIt.I<ScreenService>();
    final gameService = GetIt.I<GameService>();

    final boxes = gameService.createGame();
    final widgets = boxes.values
        .map(
          (box) => Positioned.fromRect(
            rect: screenService.getRect(box.location),
            child: BoxWidget(box: box),
          ),
        )
        .toList();

    return Stack(
      children: widgets,
    );
  }
}
