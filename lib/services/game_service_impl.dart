import '../extensions.dart';
import '../interfaces.dart';
import '../types.dart';

class GameServiceImpl implements GameService {
  GameServiceImpl(this.randomService);
  final RandomService randomService;

  final _game = Game();

  @override
  void createGame() {
    _game.grid.clear();

    for (var x = -3; x <= 3; x++) {
      for (var y = -3; y <= 3; y++) {
        final location = Location(x, y);
        final proposedColour = randomService.colour;
        final validColour = game.getValidColour(location, proposedColour);

        game.grid[location] = validColour;
      }
    }
  }

  @override
  Game get game => _game;
}
