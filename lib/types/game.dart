import 'package:equatable/equatable.dart';
import '../types.dart';

class Game extends Equatable {
  final List<Box> boxes = <Box>[];

  @override
  List<Object?> get props => [boxes];
}
