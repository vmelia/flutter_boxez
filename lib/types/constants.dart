import 'dart:math';

class Constants {
  // Game.
  static const int gridStart = -3;
  static const int gridEnd = 3;
  static const int gridSize = gridEnd - gridStart + 1;
  static const double cellOffset = 2.0;
  static const int matchesRequired = 3;

  // BoxWidgets.
  static const double boxPadding = 1.0;
  static const double boxRadius = 30.0;
  static const int boxGradientAlpha = 90;

  // Misc.
  static List<double> cardinals = [-pi, -pi/2, 0, pi/2, pi];
}
