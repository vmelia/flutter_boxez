import 'package:equatable/equatable.dart';

import '../types.dart';

class Game extends Equatable {
  final List<Box> boxes = <Box>[];

  @override
  List<Object?> get props => [boxes];

  void updateBox(Box box) {
    for (final b in boxes) {
      if (b.index == box.index) {
        boxes.remove(b);
        boxes.add(box);
      }
    }
  }
}
