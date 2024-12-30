import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../state.dart';
import '../widgets.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final gameCubit = GetIt.I<GameCubit>();
    return BlocProvider.value(
      value: gameCubit,
      child: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) =>_MainPageView(state: state),
        
      ),
    );
  }
}

class _MainPageView extends StatelessWidget {
  const _MainPageView({required this.state});
  final GameState state;

  @override
  Widget build(BuildContext context) {
    final gameCubit = GetIt.I<GameCubit>();
    return Scaffold(
      floatingActionButton: IconButtonWidget(iconData: Icons.gamepad, onPressed: () => gameCubit.createGame()),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: BoardWidget(game: state.game),
    );
  }
}
