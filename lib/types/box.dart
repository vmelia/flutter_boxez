import 'package:flutter/material.dart';

import '../types.dart';

class Box {
  Box({required this.location, required this.colour});

  late Location location; // Can be updated.
  final MaterialColor colour;
}
