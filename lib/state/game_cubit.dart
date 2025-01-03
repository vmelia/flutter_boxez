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
  GameCubit(this.gameCreatorService, this.gameDataService, this.dragService) : super(GameState.initial()) {
    dragService.boxesUpdated = boxesUpdated;
  }

  final GameCreatorService gameCreatorService;
  final GameDataService gameDataService;
  final DragService dragService;

  void createGame() {
    emit(GameState.initial());
    gameCreatorService.createGame();
    emit(GameState(game: gameCreatorService.game));
  }

  void boxesUpdated(List<Box> updates, bool done) {
    emit(GameState.initial());
    gameDataService.updateBoxes(updates);
    emit(GameState(game: gameDataService.game));
  }
}
