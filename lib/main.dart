import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futquiz/screens/splash_page.dart';
import 'package:futquiz/theme/themes.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'firebase_options.dart';
import 'screens/game_one_page.dart';
import 'screens/home_page.dart';
import 'theme/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PackageInfo.fromPlatform();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(themeNotifierProvider);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: themeProvider.darkTheme ? ThemeMode.dark : ThemeMode.light,
        theme: Themes.themeLight,
        darkTheme: Themes.themeDark,
        routes: {
          HomePage.id: (context) => HomePage(),
          GameOnePage.id: (context) => const GameOnePage(),
          SplashPage.id: (context) => const SplashPage(),
        },
        home: const SplashPage());
  }
}
