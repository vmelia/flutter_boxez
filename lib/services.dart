import 'package:get_it/get_it.dart';

import 'interfaces.dart';
import 'services.dart';

export 'services/drag_service_impl.dart';
export 'services/game_creator_service_impl.dart';
export 'services/game_data_service_impl.dart';
export 'services/game_logic_service_impl.dart';
export 'services/logger_service_impl.dart';
export 'services/random_service_impl.dart';

void configureServices() {
  GetIt.I.registerSingleton<LoggerService>(LoggerServiceImpl());
  GetIt.I.registerSingleton<RandomService>(RandomServiceImpl());
  GetIt.I.registerSingleton<GameDataService>(GameDataServiceImpl());
  GetIt.I.registerSingleton<GameCreatorService>(GameCreatorServiceImpl(GetIt.I(), GetIt.I()));
  GetIt.I.registerSingleton<GameLogicService>(GameLogicServiceImpl(GetIt.I(), GetIt.I()));
  GetIt.I.registerSingleton<DragService>(DragServiceImpl(GetIt.I()));
}
