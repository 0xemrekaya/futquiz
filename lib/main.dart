import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'screens/game_one_page.dart';
import 'screens/home_page.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true).copyWith(
          colorScheme: const ColorScheme.dark().copyWith(
            primary: const Color.fromARGB(218, 154, 226, 177),
            secondary: const Color(0xAA1737EB),
          ),
        ),
        routes: {
          HomePage.id: (context) => const HomePage(),
          GameOnePage.id: (context) => const GameOnePage(),
        },
        home: const HomePage());
  }
}
