import 'dart:math';

import 'package:equatable/equatable.dart';

class Location extends Equatable {
  const Location(this.dx, this.dy);
  const Location.zero(): dx = 0.0, dy = 0.0;
  Location.fromDirection(double direction, [ double distance = 1.0 ]) : 
    dx = distance * cos(direction), dy = distance * sin(direction);

  final double dx; //Needs to be double for dragging functionality;
  final double dy;

  Location operator +(Location other) => Location(dx + other.dx, dy + other.dy);
  Location operator -(Location other) => Location(dx - other.dx, dy - other.dy);

  double get distanceSquared => dx * dx + dy * dy;
  double get direction => atan2(dy, dx);

  @override
  List<Object?> get props => [dx, dy];
}
