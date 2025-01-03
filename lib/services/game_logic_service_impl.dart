import 'package:flutter_boxez/types/game.dart';

import '../interfaces.dart';

class GameLogicServiceImpl extends GameLogicService{
  GameLogicServiceImpl(this.gameCreatorService);
  final GameCreatorService gameCreatorService;

  @override
  Game get game => gameCreatorService.game;
}