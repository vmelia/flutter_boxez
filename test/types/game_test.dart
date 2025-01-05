import 'package:flutter_boxez/types.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Game game;

  setUp(() {
    game = Game();
  });

  Box createBox(int i) => Box(index: i, location: Location(i.toDouble(), i.toDouble()), value: i);

  group('constructor', () {
    test('boxes list is empty', () {
      expect(game.boxes.isEmpty, true);
    });
  });

  group('clone', () {
    test('clones boxes correctly', () {
      final box0 = createBox(0);
      final box1 = createBox(1);
      final box2 = createBox(2);
      game.boxes.add(box0);
      game.boxes.add(box1);
      game.boxes.add(box2);

      final clonedGame = Game.clone(game);

      expect(clonedGame.boxes.length, 3);
      expect(clonedGame.boxes.toList()[0], box0);
      expect(clonedGame.boxes.toList()[1], box1);
      expect(clonedGame.boxes.toList()[2], box2);
    });
  });
}
