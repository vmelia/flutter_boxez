import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../state.dart';
import '../types.dart';
import '../widgets.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final gameCubit = GetIt.I<GameCubit>();
    return BlocProvider.value(
      value: gameCubit..createGame(),
      child: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          return _MainPageView(game: state.game);
        },
      ),
    );
  }
}

class _MainPageView extends StatelessWidget {
  const _MainPageView({required this.game});
  final Map<Location, Box> game;

  @override
  Widget build(BuildContext context) {
    final gameCubit = GetIt.I<GameCubit>();
    return Scaffold(
      floatingActionButton: IconButtonWidget(iconData: Icons.gamepad, onPressed: () => gameCubit.createGame()),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: BoardWidget(game: game),
    );
  }
}
