import 'package:flutter_boxez/types.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Game game;

  setUp(() {
    game = Game();
  });

  group('constructor', () {
    test('boxes list is empty', () {
      expect(game.boxes.isEmpty, true);
    });
  });
}
