import 'package:equatable/equatable.dart';

import '../types.dart';

class Game extends Equatable {
  Game();

  final List<Box> _boxes = <Box>[];
  List<Box> get boxes => _boxes;

  @override
  List<Object?> get props => [_boxes];
}
