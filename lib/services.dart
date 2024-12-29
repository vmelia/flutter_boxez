import 'package:get_it/get_it.dart';

import 'interfaces.dart';
import 'services.dart';

export 'services/game_service_impl.dart';
export 'services/random_service_impl.dart';
export 'services/screen_service_impl.dart';

void configureServices() {
  GetIt.I.registerSingleton<RandomService>(RandomServiceImpl());
  GetIt.I.registerSingleton<GameService>(GameServiceImpl(GetIt.I()));
  GetIt.I.registerSingleton<ScreenService>(ScreenServiceImpl());
}