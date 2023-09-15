import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static String id = "home_page";
  final String _googleId = "964796347193-e5fc68rb5ue8ffgr6a3f484i5kmsd2vj.apps.googleusercontent.com";
  final String title = "FutQuiz";
  final String description =
      "All logos and brands are property of their respective owners and are used for identification purposes only";
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textStyle = Theme.of(context).textTheme;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: height / 10,
        actions: [
          Switch(
              thumbIcon: MaterialStateProperty.all(Icon(themeProvider.darkTheme! ? Icons.nightlight_round :Icons.wb_sunny_rounded)),
              value: themeProvider.darkTheme!,
              onChanged: (newValue) {
                themeProvider.changeTheme(newValue);
              })
        ],
      ),
      body: SafeArea(
          child: Center(
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: height / 10, horizontal: width / 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    title,
                    style: textStyle.displayMedium,
                    textAlign: TextAlign.start,
                  ),
                ),
                StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.hasError.toString()),
                        );
                      } else if (snapshot.hasData) {
                        // user signed
                        return Column(
                          children: [
                            Text(
                              "Giriş yapıldı: ${FirebaseAuth.instance.currentUser!.displayName}",
                              style: textStyle.bodyMedium,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            gameOnePlayButton(context, height, width, true, textStyle),
                            const SizedBox(
                              height: 5,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  FirebaseAuth.instance.signOut();
                                },
                                child: Text(
                                  "Çıkış yap",
                                  style: textStyle.bodyMedium,
                                )),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            Text(
                              "Lütfen giriş yapın",
                              style: textStyle.titleMedium,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: height / 40, horizontal: width / 10),
                              child: GoogleSignInButton(
                                  label: "       Google ile giriş yap",
                                  loadingIndicator: const CircularProgressIndicator(),
                                  clientId: _googleId),
                            ),
                            gameOnePlayButton(context, height, width, false, textStyle)
                          ],
                        );
                      }
                    }),
                SizedBox(height: height / 10),
                Text(description, style: textStyle.bodySmall, textAlign: TextAlign.center),
              ],
            )),
      )),
    );
  }

  FilledButton gameOnePlayButton(
      BuildContext context, double height, double width, bool isLogged, TextTheme textTheme) {
    return FilledButton(
        onPressed: isLogged
            ? () {
                Navigator.pushNamed(context, "game_one_page");
              }
            : null,
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(vertical: height / 40, horizontal: width / 5),
          ),
        ),
        child: Text("Ben kimim? Oyna!",
            style: isLogged
                ? textTheme.bodyLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.w500)
                : const TextStyle()));
  }
}
