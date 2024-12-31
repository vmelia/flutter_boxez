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
  GameCubit(this.gameService, this.dragService) : super(GameState.initial()) {
    dragService.boxesUpdated = boxesUpdated;
  }

  final GameService gameService;
  final DragService dragService;

  void createGame() {
    emit(GameState.initial());
    gameService.createGame();
    emit(GameState(game: gameService.game));
  }

  void boxesUpdated(List<Box> updates) {
    emit(GameState.initial());
    gameService.updateBoxes(updates);
    emit(GameState(game: gameService.game));
  }
}
