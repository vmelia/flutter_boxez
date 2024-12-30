import 'package:flutter/material.dart';
import 'package:flutter_boxez/services.dart';

import 'pages.dart';
import 'state.dart';

void main() {
  configureServices();
  configureState();

  runApp(const MainApp());
}

// void main() {
//   runZoned<Future<void>>(
//     () async {
//       configureServices();
//       configureState();
//       runApp(MainApp());
//     },
//     onError: (dynamic error, StackTrace stackTrace) {
//       debugPrint("=================== CAUGHT DART ERROR");
//     },
//   );
// }

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: GamePage(),
      ),
    );
  }
}
