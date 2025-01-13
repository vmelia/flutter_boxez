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
  final box0 = Box(0, Location(-1, -1), 0);
  final box1 = Box(1, Location(0, -1), 2);
  final box2 = Box(2, Location(1, -1), 0);

  final box3 = Box(3, Location(-1, 0), 2);
  final box4 = Box(4, Location(0, 0), 4);
  final box5 = Box(5, Location(1, 0), 2);

  final box6 = Box(6, Location(-1, 1), 0);
  final box7 = Box(7, Location(0, 1), 2);
  final box8 = Box(9, Location(1, 1), 0);

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

      final result = gameDataService.findByLocation(Location(0, -1));

      expect(result, box1);
    });

    test('returns null when not found', () {
      final result = gameDataService.findByLocation(Location(1, 1));

      expect(result, null);
    });
  });

  group('getMaximumDxDyValue', () {
    test('return correct value for positive x', () {
      addThreeBoxes();
      box0.moveAbsolute(Location(0, 0));
      box0.moveAbsolute(Location(-1, -1));
      box0.moveAbsolute(Location(4, 1));

      final result = gameDataService.getMaximumDxDyValue();

      expect(result, 4);
    });

    test('returns null when not found', () {
      final result = gameDataService.findByLocation(Location(1, 1));

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

  group('markBoxesForRemoval', () {
    test('marks boxes correctly', () {
      addThreeBoxes();

      gameDataService.markBoxesForRemoval({box0, box2});

      expect(gameDataService.game.boxes.length, 3); // None removed yet.
      expect(gameDataService.game.boxes[0].markedForRemoval, true);
      expect(gameDataService.game.boxes[1].markedForRemoval, false);
      expect(gameDataService.game.boxes[2].markedForRemoval, true);
    });
  });

  group('removeMarkedBoxes', () {
    test('removes marks boxes correctly', () {
      addThreeBoxes();
      gameDataService.markBoxesForRemoval({box0, box2});

      gameDataService.removeMarkedBoxes();

      expect(gameDataService.game.boxes.length, 1);
      expect(gameDataService.game.boxes.toList()[0], box1); // Unchanged.
    });
  });

  group('getSelectedColumn', () {
    test('returns correct list', () {
      createTestGame();

      final result = gameDataService.getSelectedColumn(0); // Center

      expect(result.length, 3);
      expect(result[0], box1);
      expect(result[1], box4);
      expect(result[2], box7);
    });
  });
  group('getSelectedRow', () {
    test('returns correct list', () {
      createTestGame();

      final result = gameDataService.getSelectedRow(0); // Center

      expect(result.length, 3);
      expect(result[0], box3);
      expect(result[1], box4);
      expect(result[2], box5);
    });
  });

  group('getAllColumns', () {
    test('returns all columns', () {
      createTestGame();

      final result = gameDataService.getAllColumns();

      expect(result.length, 3);
      expect(result.toList()[0], [box0, box3, box6]);
      expect(result.toList()[1], [box1, box4, box7]);
      expect(result.toList()[2], [box2, box5, box8]);
    });
  });
  group('getAllRows', () {
    test('returns all rows', () {
      createTestGame();

      final result = gameDataService.getAllRows();

      expect(result.length, 3);
      expect(result.toList()[0], [box0, box1, box2]);
      expect(result.toList()[1], [box3, box4, box5]);
      expect(result.toList()[2], [box6, box7, box8]);
    });
  });
}
