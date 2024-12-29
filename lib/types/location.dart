import 'package:equatable/equatable.dart';

class Location extends Equatable{
  const Location(this.x, this.y);
  
  final int x;
  final int y;

  @override
  List<Object?> get props => [x, y];
}