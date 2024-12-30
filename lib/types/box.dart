import 'dart:ui';

class Box {
  Box({required this.location, required this.colour});

  late Offset location; // Can be updated.
  final int colour;
}
