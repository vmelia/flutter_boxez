import 'package:flutter/material.dart';

import '../interfaces.dart';

class ScreenServiceImpl implements ScreenService {
  late Size _screenSize;

  @override
  void initialize(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
  }

  @override
  Size get screenSize => _screenSize;
}
