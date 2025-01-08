import '../types.dart';

class Box {
  Box(
    this._index,
    this._location,
    this._value,
  ) : _lastLocation = _location;

  final int _index;
  Location _location;
  final int _value;

  int get index => _index;
  Location get location => _location;
  int get value => _value;

  Location _lastLocation;

  void moveTemp(Location delta) {
    _location = _lastLocation + delta;
  }

  void moveByDelta(Location delta) {
    _location = _lastLocation + delta;
    _lastLocation = _location;
  }

  void moveAbsolute(Location location) {
    _location = location;
    _lastLocation = _location;
  }
}
