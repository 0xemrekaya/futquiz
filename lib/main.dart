import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
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
        theme: ThemeData.dark(useMaterial3: true).copyWith(
          colorScheme: ColorScheme.dark().copyWith(
            primary: Color.fromARGB(255, 5, 85, 150),
            secondary: Color.fromARGB(255, 7, 7, 103),
          ),
        ),
        home: HomeScreen());
  }
}
