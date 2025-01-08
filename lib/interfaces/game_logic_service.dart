import '../types.dart';

abstract class GameLogicService {
  bool removeContiguousBoxes();
  bool collapseToCentre();

  Refresh? refresh;
}
