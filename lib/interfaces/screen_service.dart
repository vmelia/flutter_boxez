import 'package:flutter/material.dart';
import '../types.dart';

abstract class ScreenService {
  void initialize({required Size screenSize});
  Rect getRect(Location location);
}
