import 'dart:developer';

import '../interfaces.dart';

class LoggerServiceImpl extends LoggerService {
  @override
  info(String message) {
    log(message);
  }
}
