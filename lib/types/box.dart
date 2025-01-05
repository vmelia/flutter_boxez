import 'dart:ui';

import 'package:equatable/equatable.dart';

class Box extends Equatable {
  const Box({
    required this.index,
    required this.location,
    required this.value,
  });
  final int index;
  final Offset location;
  final int value;
  
  @override
  List<Object?> get props => [index, location, value];

  Box copyWith({
    int? index,
    Offset? location,
    int? value,

  }) =>
      Box(
        index: index ?? this.index,
        location: location ?? this.location,
        value: value ?? this.value,
      );
}
