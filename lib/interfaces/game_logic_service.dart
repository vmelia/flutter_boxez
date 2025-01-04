import '../types.dart';

abstract class GameLogicService {
  Game get game;

  bool removeContiguousBoxes();
}
