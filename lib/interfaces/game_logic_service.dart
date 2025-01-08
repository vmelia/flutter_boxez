import '../types.dart';

abstract class GameLogicService {
  bool removeContiguousBoxes();
  bool collapseToCentre();

  BoxesUpdated? boxesFinished;
}
