import 'package:equatable/equatable.dart';

import '../types.dart';

class Game extends Equatable {
  final Map<Location, Box> _grid = {};

  Map<Location, Box> get grid => _grid;
  List<Box> get boxes => _grid.values.toList();

  void add(Location location, Box box) => _grid[location] = box;

  @override
  List<Object?> get props => [_grid];
}
