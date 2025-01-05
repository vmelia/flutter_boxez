import 'package:flutter_boxez/types.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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

  group('distanceSquared', () {
    test('returns correct value', () {
      final location = Location(2.0, 3.0);

      final result = location.distanceSquared;

      expect(result, 2 * 2 + 3 * 3);
    });
  });
}
