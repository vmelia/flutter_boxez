import 'dart:math';

import '../helpers.dart';
import '../interfaces.dart';
import '../types.dart';

class RandomServiceImpl implements RandomService {
  final Random _random = Random();

  @override
  Location get location => Location(_nextLocationValue(), _nextLocationValue());

  @override
  int get colour => _next(Colours.count);

  int _nextLocationValue() => _next(Constants.gridSize) - Constants.cellOffset;
  int _next(int max) => _random.nextInt(max);
}
