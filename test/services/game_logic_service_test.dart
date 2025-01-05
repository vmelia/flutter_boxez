import 'package:flutter_boxez/interfaces.dart';
import 'package:flutter_boxez/services.dart';
import 'package:flutter_boxez/types.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  late MockGameDataService gameDataService;
  late GameLogicService gameLogicService;

  setUp(() {
    gameDataService = MockGameDataService();
    gameLogicService = GameLogicServiceImpl(gameDataService);
  });

  group('removeContiguousBoxes', () {
    test('removes three in a column correctly', () {
      final box0 = Box(index: 0, location: Location(0, -2), value: 0);
      final box1 = Box(index: 1, location: Location(0, -1), value: 1);
      final box2 = Box(index: 2, location: Location(0, 0), value: 1);
      final box3 = Box(index: 3, location: Location(0, 1), value: 1);
      final box4 = Box(index: 4, location: Location(0, 2), value: 0);

      final column = [box0, box1, box2, box3, box4];
      gameDataService.allColumns = [column];

      final result = gameLogicService.removeContiguousBoxes();

      expect(result, true);
      expect(gameDataService.removed, [box1, box2, box3]);
    });
    test('removes three in a row correctly', () {
      final box0 = Box(index: 0, location: Location(-2, 0), value: 0);
      final box1 = Box(index: 1, location: Location(-1, 0), value: 1);
      final box2 = Box(index: 2, location: Location(0, 0), value: 1);
      final box3 = Box(index: 3, location: Location(1, 0), value: 1);
      final box4 = Box(index: 4, location: Location(2, 0), value: 0);

      final row = [box0, box1, box2, box3, box4];
      gameDataService.allRows = [row];

      final result = gameLogicService.removeContiguousBoxes();

      expect(result, true);
      expect(gameDataService.removed, [box1, box2, box3]);
    });
  });
}

class MockGameDataService extends GameDataService {
  late Iterable<List<Box>> allColumns = List<List<Box>>.empty();
  late Iterable<List<Box>> allRows = List<List<Box>>.empty();
  late List<Box> removed = <Box>[];

  @override
  void add(Box box) {}

  @override
  void createEmptyGame() {}

  @override
  Box? findByLocation(Location location) => null;

  @override
  Game get game => Game();

  @override
  Iterable<List<Box>> getAllColumns() => allColumns;

  @override
  Iterable<List<Box>> getAllRows() => allRows;

  @override
  Map<Location, Box> getSelectedColumn(int index) => {};

  @override
  Map<Location, Box> getSelectedRow(int index) => {};

  @override
  void remove(Box box) {}

  @override
  void removeBoxes(List<Box> updates) => removed = updates;

  @override
  void updateBoxes(List<Box> updates) {}
}
