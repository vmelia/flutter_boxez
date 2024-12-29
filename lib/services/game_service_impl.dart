import 'package:flutter_boxez/extensions.dart';

import '../interfaces.dart';
import '../types.dart';

class GameServiceImpl implements GameService {
  GameServiceImpl(this.randomService);
  final RandomService randomService;

  @override
  Map<Location, Box> createGame() {
    final boxes = <Location, Box>{};
    for (var x = -3; x <= 3; x++) {
      for (var y = -3; y <= 3; y++) {
        final location = Location(x, y);
        final proposedColour = randomService.colour;
        final validColour = boxes.getValidColour(location, proposedColour);

        boxes[location] = Box(location: location, colour: validColour);
      }
    }

    return boxes;
  }
}
