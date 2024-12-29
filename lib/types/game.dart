import 'package:equatable/equatable.dart';
import '../types.dart';

class Game extends Equatable {
  final Map<Location, Box> grid = {};
  
  
  @override
  List<Object?> get props => [grid];
}
