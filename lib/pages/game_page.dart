import 'package:flutter/material.dart';

import '../services.dart';
import '../widgets.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final boxes = GameServiceImpl(RandomServiceImpl()).createGame();

    final screenSize = MediaQuery.of(context).size;
    final screenService = ScreenServiceImpl(screenSize: screenSize);
    final widgets = boxes.values
        .map(
          (box) => Positioned.fromRect(
            rect: screenService.getRect(box),
            child: BoxWidget(box: box),
          ),
        )
        .toList();

    return Stack(
      children: widgets,
    );
  }
}
