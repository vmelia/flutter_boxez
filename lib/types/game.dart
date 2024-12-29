import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../types.dart';

class Game extends Equatable {
  final Map<Location, MaterialColor> _grid = {};

  Map<Location, MaterialColor> get grid => _grid;

  @override
  List<Object?> get props => [_grid];
}
