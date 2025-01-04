import '../interfaces.dart';
import '../types.dart';

class GameProviderServiceImpl extends GameProviderService {
  final Game _game = Game();
  
  @override
  Game get game => _game;
}