import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../interfaces.dart';
import '../types.dart';

class GameState extends Equatable {
  const GameState({required this.game, required this.isDragging});
  GameState.initial()
      : game = Game(),
        isDragging = false;
  final Game game;
  final bool isDragging;

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
    dragService.moveInProgress = _moveInProgress;
    dragService.moveMade = _moveMade;
    gameLogicService.moveMade = _moveMade;
  }

  final GameCreatorService gameCreatorService;
  final GameDataService gameDataService;
  final GameLogicService gameLogicService;
  final DragService dragService;

  void createGame() {
    gameCreatorService.createGame();
    emit(GameState(game: gameDataService.game, isDragging: false));
  }

  void _moveInProgress() {
    _emitDraggingGameState();
  }

  void _moveMade() {
    _emitDoneGameState();

    Set<Box> boxesRemoved;
    var anyChanges = false;
    do {
      boxesRemoved = gameLogicService.removeContiguousBoxes();
      if (boxesRemoved.isNotEmpty) {
        //TODO: Explode boxes?
        _emitDoneGameState();
        anyChanges = gameLogicService.collapseToCentre();
        if (anyChanges) {
          _emitDoneGameState();
        }
      }
    } while (boxesRemoved.isNotEmpty && anyChanges);
  }

  void _emitDraggingGameState() {
    emit(GameState.initial());
    emit(GameState(game: gameDataService.game, isDragging: true));
  }

  void _emitDoneGameState() {
    emit(GameState.initial());
    emit(GameState(game: gameDataService.game, isDragging: false));
  }
}
