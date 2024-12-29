import 'package:flutter/material.dart';
import 'package:flutter_boxez/types.dart';

class BoxWidget extends StatelessWidget {
  const BoxWidget({super.key, required this.colour});
  final MaterialColor colour;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Constants.boxPadding),
      child: Container(
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.all(Radius.circular(Constants.boxRadius)),
        ),
      ),
    );
  }
}
