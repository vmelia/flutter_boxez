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
}
