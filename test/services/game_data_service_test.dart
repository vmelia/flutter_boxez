import 'package:flutter_boxez/interfaces.dart';
import 'package:flutter_boxez/services.dart';
import 'package:flutter_boxez/types.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GameDataService gameDataService;

  setUp(() {
    gameDataService = GameDataServiceImpl();
    gameDataService.createEmptyGame();
  });

  // Test game.
  // -------------
  // | 0 | 2 | 0 |
  // -------------
  // | 2 | 4 | 2 |
  // -------------
  // | 0 | 2 | 0 |
  // -------------
  final box0 = Box(index: 0, location: Offset(-1, -1), value: 0);
  final box1 = Box(index: 1, location: Offset(0, -1), value: 2);
  final box2 = Box(index: 2, location: Offset(1, -1), value: 0);

  final box3 = Box(index: 3, location: Offset(-1, 0), value: 2);
  final box4 = Box(index: 4, location: Offset(0, 0), value: 4);
  final box5 = Box(index: 5, location: Offset(1, 0), value: 2);

  final box6 = Box(index: 6, location: Offset(-1, 1), value: 0);
  final box7 = Box(index: 7, location: Offset(0, 1), value: 2);
  final box8 = Box(index: 9, location: Offset(1, 1), value: 0);

  void createTestGame() {
    gameDataService.add(box0);
    gameDataService.add(box1);
    gameDataService.add(box2);
    gameDataService.add(box3);
    gameDataService.add(box4);
    gameDataService.add(box5);
    gameDataService.add(box6);
    gameDataService.add(box7);
    gameDataService.add(box8);
  }

  // Adds boxes with index 0..2.
  // Offsets (-1..1, -1).
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

      final result = gameDataService.findByLocation(Offset(0, -1));

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

  group('removeBoxes', () {
    test('removes boxes correctly', () {
      addThreeBoxes();

      gameDataService.removeBoxes([box0, box2]);

      expect(gameDataService.game.boxes.length, 1);
      expect(gameDataService.game.boxes.toList()[0], box1); // Unchanged.
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

  group('getSelectedColumn', () {
    test('returns correct list', () {
      createTestGame();

      final result = gameDataService.getSelectedColumn(0); // Center

      expect(result.length, 3);
      expect(result[Offset(0, -1)], box1);
      expect(result[Offset(0, 0)], box4);
      expect(result[Offset(0, 1)], box7);
    });
  });
  group('getSelectedRow', () {
    test('returns correct list', () {
      createTestGame();

      final result = gameDataService.getSelectedRow(0); // Center

      expect(result.length, 3);
      expect(result[Offset(-1, 0)], box3);
      expect(result[Offset(0, 0)], box4);
      expect(result[Offset(1, 0)], box5);
    });
  });

  group('xxxx', () {
    test('xxxx', () {});
  });
  group('xxxx', () {
    test('xxxx', () {});
  });
}
