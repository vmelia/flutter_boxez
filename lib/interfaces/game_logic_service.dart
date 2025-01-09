import '../types.dart';

abstract class GameLogicService {
  Set<Box> removeContiguousBoxes();
  bool collapseToCentre();

  MoveMade? moveMade;
}
