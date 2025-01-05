import 'package:equatable/equatable.dart';

import '../types.dart';

class Box extends Equatable {
  const Box({
    required this.index,
    required this.location,
    required this.value,
  });
  final int index;
  final Location location;
  final int value;
  
  @override
  List<Object?> get props => [index, location, value];

  Box copyWith({
    int? index,
    Location? location,
    int? value,

  }) =>
      Box(
        index: index ?? this.index,
        location: location ?? this.location,
        value: value ?? this.value,
      );
}
