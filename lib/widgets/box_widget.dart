import 'package:flutter/material.dart';
import 'package:flutter_boxez/types.dart';

class BoxWidget extends StatelessWidget {
  const BoxWidget({super.key, required this.box});
  final Box box;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Constants.boxPadding),
      child: Container(
        decoration: BoxDecoration(
          color: box.colour,
          borderRadius: BorderRadius.all(Radius.circular(Constants.boxRadius)),
        ),
      ),
    );
  }
}
