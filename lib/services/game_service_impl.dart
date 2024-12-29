import '../extensions.dart';
import '../interfaces.dart';
import '../types.dart';

class GameServiceImpl implements GameService {
  GameServiceImpl(this.randomService);
  final RandomService randomService;

  @override
  Game createGame() {
    final game = Game();
    for (var x = -3; x <= 3; x++) {
      for (var y = -3; y <= 3; y++) {
        final location = Location(x, y);
        final proposedColour = randomService.colour;
        final validColour = game.getValidColour(location, proposedColour);

        final box = Box(location: location, colour: validColour);
        game.add(location, box);
      }
    }

    return game;
  }
}
