import 'package:flutter/material.dart';
import 'package:flutter_boxez/helpers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  group('count', () {
    test('returns correct number', () {
      expect(Colours.count, 6);
    });
  });

  group('convertToColour', () {
    parameterizedTest(
      'returned colour is correct',
      [
        [0, Colors.red],
        [1, Colors.orange],
        [2, Colors.yellow],
        [3, Colors.green],
        [4, Colors.blue],
        [5, Colors.purple],
      ],
      (int colour, MaterialColor expected) {
        final actual = Colours.convertToColour(colour);

        expect(actual, expected);
      },
    );
  });
}
