import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final double dx; //Needs to be double for dragging functionality;
  final double dy;

  const Location(this.dx, this.dy);

  Location operator +(Location other) => Location(dx + other.dx, dy + other.dy);

  @override
  List<Object?> get props => [dx, dy];
}
