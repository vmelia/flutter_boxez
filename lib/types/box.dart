import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../types.dart';

class Box extends Equatable {
  Box({required this.location, required this.colour});

  late Location location; // Can be updated.
  final MaterialColor colour;

  @override
  List<Object?> get props => [location, colour];
}
