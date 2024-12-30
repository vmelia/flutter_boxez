import 'package:flutter/material.dart';
import 'package:flutter_boxez/services.dart';
import 'package:get_it/get_it.dart';

import 'interfaces.dart';
import 'pages.dart';
import 'state.dart';

void main() {
  configureServices();
  configureState();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final screenService = GetIt.I<ScreenService>();
    screenService.initialize(context);
    
    return const MaterialApp(
      home: Scaffold(
        body: GamePage(),
      ),
    );
  }
}
