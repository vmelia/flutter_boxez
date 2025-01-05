import 'package:flutter_boxez/interfaces.dart';
import 'package:flutter_boxez/services.dart';
import 'package:flutter_boxez/types.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GameDataService gameDataService;

  setUp(() {
    gameDataService = GameDataServiceImpl();
    gameDataService.createNewGame();
  });

  Box createBox(int i) => Box(index: i, location: Offset(i.toDouble(), i.toDouble()), value: i);

  final box0 = createBox(0);
  final box1 = createBox(1);
  final box2 = createBox(2);

  void addThreeBoxes() {
    gameDataService.add(box0);
    gameDataService.add(box1);
    gameDataService.add(box2);
  }

  group('constructor', () {
    test('creates a new, empty, game', () {
      expect(gameDataService.game.boxes.isEmpty, true);
    });
  });

  group('findByLocation', () {
    test('finds existing box', () {
      addThreeBoxes();

      final result = gameDataService.findByLocation(Offset(1, 1));

      expect(result, box1);
    });

    test('returns null when not found', () {
      final result = gameDataService.findByLocation(Offset(1, 1));

      expect(result, null);
    });
  });

  group('add', () {
    test('adds box to boxes', () {
      addThreeBoxes();

      expect(gameDataService.game.boxes.length, 3);
      expect(gameDataService.game.boxes.toList()[0], box0);
      expect(gameDataService.game.boxes.toList()[1], box1);
      expect(gameDataService.game.boxes.toList()[2], box2);
    });
  });

  group('remove', () {
    test('removes box from boxes', () {
      addThreeBoxes();

      gameDataService.remove(box1);

      expect(gameDataService.game.boxes.length, 2);
      expect(gameDataService.game.boxes.toList()[0], box0);
      expect(gameDataService.game.boxes.toList()[1], box2);
    });
  });

  group('updateBoxes', () {
    test('updates boxes correctly', () {
      addThreeBoxes();

      final newBox0 = Box(index: 0, location: Offset(10, 10), value: 0);
      final newBox2 = Box(index: 2, location: Offset(12, 12), value: 2);

      gameDataService.updateBoxes([newBox0, newBox2]);

      expect(gameDataService.game.boxes.length, 3);
      expect(gameDataService.game.boxes.toList()[0], box1); // Unchanged.
      expect(gameDataService.game.boxes.toList()[1], newBox0);
      expect(gameDataService.game.boxes.toList()[2], newBox2);
    });
  });

  group('removeBoxes', () {
    test('removes boxes correctly', () {
      addThreeBoxes();

      gameDataService.removeBoxes([box0, box2]);

      expect(gameDataService.game.boxes.length, 1);
      expect(gameDataService.game.boxes.toList()[0], box1); // Unchanged.
    });
  });
}
