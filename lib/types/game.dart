import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../types.dart';

class Game extends Equatable {
  final Map<Location, MaterialColor> grid = {};
  
  @override
  List<Object?> get props => [grid];
}
