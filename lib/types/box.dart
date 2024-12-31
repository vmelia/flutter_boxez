import 'dart:ui';

import 'package:equatable/equatable.dart';

class Box extends Equatable {
  const Box({
    required this.index,
    required this.location,
    required this.colour,
  });
  final int index;
  final Offset location;
  final int colour;
  
  @override
  List<Object?> get props => [index, location, colour];

  Box copyWith({
    int? index,
    Offset? location,
    int? colour,

  }) =>
      Box(
        index: index ?? this.index,
        location: location ?? this.location,
        colour: colour ?? this.colour,
      );
}
