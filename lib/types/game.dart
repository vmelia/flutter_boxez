import 'dart:ui';

import 'package:equatable/equatable.dart';

import '../types.dart';

class Game extends Equatable {
  final List<Box> _boxes = <Box>[];

  Iterable<Box> get boxes => _boxes;

  void add(Box box) => _boxes.add(box);
  void remove(Box box) => _boxes.remove(box);
  void removeList(List<Box> list) => _boxes.removeWhere((box) => list.contains(box));
  void clear() => _boxes.clear();

  Box? findByLocation(Offset location) {
    for (final box in boxes) {
      if (box.location == location) return box;
    }

    return null;
  }

  @override
  List<Object?> get props => [_boxes];
}
