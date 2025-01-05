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
}
