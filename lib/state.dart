import 'package:get_it/get_it.dart';
import 'state/game_cubit.dart';

export 'state/game_cubit.dart';

void configureState() {
  GetIt.I.registerSingleton<GameCubit>(GameCubit(GetIt.I(), GetIt.I(), GetIt.I(), GetIt.I(), GetIt.I()));
}
