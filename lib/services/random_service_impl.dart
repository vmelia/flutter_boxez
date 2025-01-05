import 'dart:math';
import 'dart:ui';

import '../helpers.dart';
import '../interfaces.dart';
import '../types.dart';

class RandomServiceImpl implements RandomService {
  final Random _random = Random();

  @override
  Offset get location => Offset(_nextLocationValue(), _nextLocationValue());

  @override
  int get value => _next(Colours.count);

  double _nextLocationValue() => (_next(Constants.gridSize.toInt())) - Constants.cellOffset;
  int _next(int max) => _random.nextInt(max);
}
