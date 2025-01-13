import 'package:flutter_boxez/types.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('constructor', () {
    test('sets values correctly', () {
      final box = Box(2, Location(3, 4), 5);

      expect(box.index, 2);
      expect(box.location, Location(3, 4));
      expect(box.value, 5);
      expect(box.markedForRemoval, false);
    });
  });

  group('markForRemoval', () {
    test('updates box correctly', () {
      final box = Box(2, Location(3, 4), 5);

      box.moveTemp(Location(1, -1));

      expect(box.location, Location(4, 3));
    });
  });

  group('moveTemp', () {
    test('updates box correctly', () {
      final box = Box(2, Location(3, 4), 5);

      box.moveTemp(Location(1, -1));

      expect(box.location, Location(4, 3));
    });
  });

  group('moveByDelta', () {
    test('updates box correctly', () {
      final box = Box(2, Location(3, 4), 5);

      box.moveByDelta(Location(1, -1));

      expect(box.location, Location(4, 3));
    });
  });

  group('moveAbsolute', () {
    test('updates box correctly', () {
      final box = Box(2, Location(3, 4), 5);

      box.moveAbsolute(Location(1, -1));

      expect(box.location, Location(1, -1));
    });
  });
}
