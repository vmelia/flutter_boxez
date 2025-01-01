import 'dart:ui';

import '../types.dart';

extension GameExtensions on Game {
  Map<Offset, Box> getSelectedRow(Box box) {
    final map = <Offset, Box>{};
    for (final b in boxes) {
      if (b.location.dy == box.location.dy) {
        map[b.location] = b;
      }
    }

    return map;
  }

  Map<Offset, Box> getSelectedColumn(Box box) {
    final map = <Offset, Box>{};
    for (final b in boxes) {
      if (b.location.dx == box.location.dx) {
        map[b.location] = b;
      }
    }

    return map;
  }

  Offset getMinAndMaxCoordinates() {
    double minimum = double.infinity;
    double maximum = -double.infinity;
    for(final box in boxes) {
      if (box.location.dx < minimum) {
        minimum = box.location.dx;
      }
      if (box.location.dy < minimum) {
        minimum = box.location.dy;
      }
      if (box.location.dx > maximum) {
        maximum = box.location.dx;
      }
      if (box.location.dy > maximum) {
        maximum = box.location.dy;
      }
    }

    return Offset(minimum, maximum);
  }
}
