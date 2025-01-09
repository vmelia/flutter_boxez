import 'package:flutter_boxez/interfaces.dart';
import 'package:flutter_boxez/services.dart';
import 'package:flutter_boxez/types.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  late MockGameDataService gameDataService;
  late MockLoggerService loggerService;
  late GameLogicService gameLogicService;

  setUp(() {
    gameDataService = MockGameDataService();
    loggerService = MockLoggerService();
    gameLogicService = GameLogicServiceImpl(gameDataService, loggerService);
  });

  group('removeContiguousBoxes', () {
    test('removes three in a column correctly', () {
      final box0 = Box(0, Location(0, -2), 0);
      final box1 = Box(1, Location(0, -1), 1);
      final box2 = Box(2, Location(0, 0), 1);
      final box3 = Box(3, Location(0, 1), 1);
      final box4 = Box(4, Location(0, 2), 0);

      final column = [box0, box1, box2, box3, box4];
      gameDataService.allColumns = [column];

      final result = gameLogicService.removeContiguousBoxes();

      expect(result, true);
      expect(gameDataService.removed, [box1, box2, box3]);
    });
    test('removes three in a row correctly', () {
      final box0 = Box(0, Location(-2, 0), 0);
      final box1 = Box(1, Location(-1, 0), 1);
      final box2 = Box(2, Location(0, 0), 1);
      final box3 = Box(3, Location(1, 0), 1);
      final box4 = Box(4, Location(2, 0), 0);

      final row = [box0, box1, box2, box3, box4];
      gameDataService.allRows = [row];

      final result = gameLogicService.removeContiguousBoxes();

      expect(result, true);
      expect(gameDataService.removed, [box1, box2, box3]);
    });
    test('removes three in a column and row correctly', () {
      final box0 = Box(0, Location(0, -2), 0);
      final box1 = Box(1, Location(0, -1), 1);
      final box2 = Box(2, Location(0, 0), 1);
      final box3 = Box(3, Location(0, 1), 1);
      final box4 = Box(4, Location(0, 2), 0);
      final box5 = Box(5, Location(-2, 0), 0);
      final box6 = Box(6, Location(-1, 0), 1);
      final box7 = Box(7, Location(1, 0), 1);
      final box8 = Box(8, Location(2, 0), 0);

      final column = [box0, box1, box2, box3, box4];
      gameDataService.allColumns = [column];
      final row = [box5, box6, box2, box7, box8];
      gameDataService.allRows = [row];

      final result = gameLogicService.removeContiguousBoxes();

      expect(result, true);
      expect(gameDataService.removed, [box1, box2, box3, box6, box7]);
    });
    test('ignores column sequence with gaps', () {
      final box0 = Box(0, Location(0, -2), 0);
      final box1 = Box(1, Location(0, -1), 0);
      // No value at (0, 0).
      final box3 = Box(3, Location(0, 1), 0);
      final box4 = Box(4, Location(0, 2), 0);

      final column = [box0, box1, box3, box4];
      gameDataService.allColumns = [column];

      final result = gameLogicService.removeContiguousBoxes();

      expect(result, false);
      expect(gameDataService.removed, []);
    });
    test('ignores row sequence with gaps', () {
      final box0 = Box(0, Location(-2, 0), 0);
      final box1 = Box(1, Location(-1, 0), 0);
      // No value at (0, 0).
      final box3 = Box(3, Location(1, 0), 0);
      final box4 = Box(4, Location(2, 0), 0);

      final row = [box0, box1, box3, box4];
      gameDataService.allRows = [row];

      final result = gameLogicService.removeContiguousBoxes();

      expect(result, false);
      expect(gameDataService.removed, []);
    });
  });
}

class MockGameDataService extends GameDataService {
  late Iterable<List<Box>> allColumns = List<List<Box>>.empty();
  late Iterable<List<Box>> allRows = List<List<Box>>.empty();
  late Set<Box> removed = <Box>{};

  @override
  void add(Box box) {}

  @override
  void createEmptyGame() {}

  @override
  Box? findByLocation(Location location) => null;

  @override
  int getMaximumDxDyValue() => 0;

  @override
  Game get game => Game();

  @override
  Iterable<List<Box>> getAllColumns() => allColumns;

  @override
  Iterable<List<Box>> getAllRows() => allRows;

  @override
  List<Box> getSelectedColumn(int index) => [];

  @override
  List<Box> getSelectedRow(int index) => [];

  @override
  void markBoxesForRemoval(Set<Box> updates) => removed = updates;
}

class MockLoggerService extends LoggerService {
  late String loggedMessage;

  @override
  info(String message) => loggedMessage = message;
}
