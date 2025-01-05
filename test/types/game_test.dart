import 'package:flutter_boxez/types.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Game game;

  setUp(() {
    game = Game();
  });

  //Box createBox(int i) => Box(index: i, location: Offset(i.toDouble(), i.toDouble()), value: i);

  group('constructor', () {
    test('boxes list is empty', () {
      expect(game.boxes.isEmpty, true);
    });
  });
  
  // group('add', () {
  //   test('adds box to boxes', () {
  //     final box = createBox(0);

  //     game.add(box);
  //     expect(game.boxes.length, 1);
  //     expect(game.boxes.toList()[0], box);
  //   });
  // });

  // group('remove', () {
  //   test('removes box from boxes', () {
  //     final box0 = createBox(0);
  //     final box1 = createBox(1);
  //     final box2 = createBox(2);

  //     game.add(box0);
  //     game.add(box1);
  //     game.add(box2);

  //     game.remove(box1);

  //     expect(game.boxes.length, 2);
  //     expect(game.boxes.toList()[0], box0);
  //     expect(game.boxes.toList()[1], box2);
  //   });
  // });
}
    // test('gutter game', () {
    //   game.rollMany(20, 0);

    //   expect(game.score(), 0);
    // });

// void add(Box box) => _boxes.add(box);
// void remove(Box box) => _boxes.remove(box);
// void removeList(List<Box> list) => _boxes.removeWhere((box) => list.contains(box));
// void clear() => _boxes.clear();