import 'package:equatable/equatable.dart';

import '../types.dart';

class Game extends Equatable {
  final List<Box> _boxes = <Box>[];

  List<Box> get boxes => _boxes;  //TODO: Readonly?
  
  @override
  List<Object?> get props => [_boxes];
}
