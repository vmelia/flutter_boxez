import 'package:flutter/material.dart';
import 'package:flutter_boxez/extensions.dart';
import 'package:flutter_boxez/types.dart';

import '../widgets.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({super.key, required this.game});
  final Map<Location, Box> game;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final widgets = game.values
        .map(
          (box) => Positioned.fromRect(
            rect: box.location.getRect(screenSize),
            child: BoxWidget(box: box),
          ),
        )
        .toList();

    return Stack(
      children: widgets,
    );
  }
}
