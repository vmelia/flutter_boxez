import 'package:flutter/material.dart';
import 'package:flutter_boxez/types.dart';

import '../helpers.dart';

class BoxWidget extends StatelessWidget {
  const BoxWidget({super.key, required this.box, required this.isDragging});
  final Box box;
  final bool isDragging;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned.fromRect(
      key: Key(box.index.toString()),
      duration: isDragging ? Duration.zero : Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      rect: WidgetHelper.getRect(box.location, context),
      child: Padding(
        padding: EdgeInsets.all(Constants.boxPadding),
        child: _BoxWidgetView(box: box),
      ),
    );
  }
}

class _BoxWidgetView extends StatelessWidget {
  const _BoxWidgetView({required this.box});
  final Box box;

  @override
  Widget build(BuildContext context) {
    // final dx = box.location.dx;
    // final dy = box.location.dy;
    return Stack(
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
        //Text('($dx, $dy)\n${box.index}'),
      ],
    );
  }
}
