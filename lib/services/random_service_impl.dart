import 'dart:math';
import 'package:flutter/material.dart';

import '../interfaces.dart';
import '../types.dart';

class RandomServiceImpl implements RandomService {
  final Random _random = Random();

  @override
  Location get location => Location(_next(Constants.gridSize) - 2, _next(Constants.gridSize) - 2);

  @override
  MaterialColor get colour {
    final index = _next(Constants.colours.length);
    return Constants.colours[index];
  }

  int _next(int max) => _random.nextInt(max);
}
