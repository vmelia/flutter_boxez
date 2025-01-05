import '../types.dart';

abstract class GameLogicService {
  bool removeContiguousBoxes();
  void plugGaps();

  BoxesUpdated? boxesMoving;
}
