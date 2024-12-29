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
  GameCubit(this.gameService) : super(GameState.initial());
  final GameService gameService;

  void createGame() {
    gameService.createGame();
    emit(GameState(game: gameService.game));
  }
}
