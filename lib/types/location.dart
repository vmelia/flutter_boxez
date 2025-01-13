import 'package:equatable/equatable.dart';

class Location extends Equatable {
  const Location(this.dx, this.dy);
  const Location.zero(): dx = 0.0, dy = 0.0;
  Location.fromInt(int x, int y): dx = x.toDouble(), dy = y.toDouble();

  final double dx; //Needs to be double for dragging functionality;
  final double dy;

  Location operator +(Location other) => Location(dx + other.dx, dy + other.dy);
  Location operator -(Location other) => Location(dx - other.dx, dy - other.dy);

  @override
  List<Object?> get props => [dx, dy];
}
