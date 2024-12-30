import 'package:flutter/material.dart';

abstract class ScreenService {
  void initialize(BuildContext context);
  Size get screenSize;
}