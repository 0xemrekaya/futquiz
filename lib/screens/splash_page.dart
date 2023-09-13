import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  static String id = "splash_page";

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late PackageInfo packageInfo;
  String? appVersion;
  late String version;
  double _opacity = 0;
  final String _showAboutDialogTitle = "Uygulamanın versiyonu: ";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _getVersionFromApp() async {
    packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
  }

  Future<void> _getVersionFromFirestore() async {
    final v = await _firestore.collection("app_version").doc("v").get();
    version = v.data()!["version"];
  }

  void checkAppVersion() {
    if (appVersion == version) {
      Navigator.pushReplacementNamed(context, "home_page");
    } else {
      showAboutDialog(context: context, applicationVersion: _showAboutDialogTitle + appVersion!, children: [
        const Text("Uygulmanın yeni bir versiyonu mevcut. Lütfen yeni versiyonu indirin."),
      ]);
    }
  }

  @override
  void initState() {
    super.initState();
    _getVersionFromApp();
    _getVersionFromFirestore();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          LottieBuilder.asset(
            'assets/lottie/splash_ball.json',
            width: 300,
            height: 300,
            fit: BoxFit.fill,
          ),
          AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(seconds: 2),
            child: Column(
              children: [
                Text(
                  "FutQuiz",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  "Version: $appVersion",
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            onEnd: () => checkAppVersion(),
          ),
        ],
      ),
    ));
  }
}
