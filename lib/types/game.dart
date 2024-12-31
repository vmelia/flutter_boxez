import 'package:equatable/equatable.dart';

import '../types.dart';

class Game extends Equatable {
  final List<Box> boxes = <Box>[];

  @override
  List<Object?> get props => [boxes];

  void updateBoxes(List<Box> updates) {
    updates.forEach(_updateBox);
  }

  void _updateBox(Box update) {
    final foundBox = boxes.firstWhere((x) => x.index == update.index);
    boxes.remove(foundBox);
    boxes.add(update);
  }
}
