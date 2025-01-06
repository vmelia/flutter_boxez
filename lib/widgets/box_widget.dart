import 'package:flutter/material.dart';
import 'package:flutter_boxez/types.dart';

import '../helpers.dart';

class BoxWidget extends StatelessWidget {
  const BoxWidget({super.key, required this.box});
  final Box box;

  @override
  Widget build(BuildContext context) {
    final dx = box.location.dx;
    final dy = box.location.dy;
    final locationText = '($dx, $dy)';
    return Padding(
      padding: EdgeInsets.all(Constants.boxPadding),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colours.convertToColour(box.value).withAlpha(Constants.boxGradientAlpha),
                  Colours.convertToColour(box.value),
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(Constants.boxRadius)),
            ),
          ),
          Text(locationText),
        ],
      ),
    );
  }
}
