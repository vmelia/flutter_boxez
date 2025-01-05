import 'package:equatable/equatable.dart';

import '../types.dart';

class Game extends Equatable {
  Game();
  
  Game.clone(Game from){
    for (var b in from._boxes) {
      _boxes.add(b);
    }
  }

  final List<Box> _boxes = <Box>[];
  List<Box> get boxes => _boxes;

  @override
  List<Object?> get props => [_boxes];
}
