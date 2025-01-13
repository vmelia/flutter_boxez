import 'package:flutter_boxez/types.dart';
import 'package:flutter_test/flutter_test.dart';

//const Location.zero(): dx = 0.0, dy = 0.0;
//Location.fromInt(int x, int y): dx = x.toDouble(), dy = y.toDouble();
void main() {
  group('constructors', () {
    test('Location.zero() works correctly', () {
      final location = Location.zero();

      expect(location, Location(0.0, 0.0));
    });
    test('Location.fromInt() works correctly', () {
      final location = Location.fromInt(2, 3);

      expect(location, Location(2.0, 3.0));
    });
  });

  group('+', () {
    test('updates coordinates correctly', () {
      final location = Location(-1.0, 1.0);

      final result = location + Location(1.5, -1.5);

      expect(result, Location(0.5, -0.5));
    });
  });
  group('-', () {
    test('updates coordinates correctly', () {
      final location = Location(-1.0, 1.0);

      final result = location - Location(-1.5, 1.5);

      expect(result, Location(0.5, -0.5));
    });
  });
}
