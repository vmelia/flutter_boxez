import 'package:flutter/material.dart';
import 'package:flutter_boxez/types.dart';

import '../extensions.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({super.key, required this.game});
  final Game game;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final widgets = game.convertBoxesIntoWidgets(screenSize);

    return Scaffold(
      body: GestureDetector(
        onPanStart: (details) {},
        onPanUpdate: (details) {},
        onPanEnd: (details) {},
        child: Stack(
          alignment: Alignment.center,
          children: widgets,
        ),
      ),
    );
  }
}
