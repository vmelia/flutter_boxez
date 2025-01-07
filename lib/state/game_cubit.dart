import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../interfaces.dart';
import '../types.dart';

class GameState extends Equatable {
  const GameState({required this.game});
  GameState.initial() : game = Game();
  final Game game;

  @override
  List<Object?> get props => [game];
}

class GameCubit extends Cubit<GameState> {
  GameCubit(
    this.gameCreatorService,
    this.gameDataService,
    this.dragService,
    this.gameLogicService,
  ) : super(GameState.initial()) {
    dragService.boxesMoving = boxesMoving;
    dragService.boxesFinished = boxesFinished;
    gameLogicService.boxesMoving = boxesMoving;
  }

  final GameCreatorService gameCreatorService;
  final GameDataService gameDataService;
  final GameLogicService gameLogicService;
  final DragService dragService;

  void createGame() {
    gameCreatorService.createGame();
    emit(GameState(game: gameDataService.game));
  }

  void boxesMoving(Set<Box> updates) {
    emit(GameState.initial());
    gameDataService.updateBoxes(updates);
    emit(GameState(game: gameDataService.game));
  }

  void boxesFinished(Set<Box> updates) {
    emit(GameState.initial());
    gameDataService.updateBoxes(updates);
    emit(GameState(game: gameDataService.game));

    final anyRemoved = gameLogicService.removeContiguousBoxes();
    if (anyRemoved) {
      emit(GameState(game: gameDataService.game));
      // gameLogicService.collapseToCentre();
      // emit(GameState(game: gameDataService.game));
    }
  }
}
