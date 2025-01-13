import 'package:flutter/material.dart';
import 'package:flutter_boxez/helpers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('convertToColour', () {
    test('returned colour is correct', () {
      final actual = Colours.convertToColour(0);
      expect(actual, Colors.red);
    });
  });
}
