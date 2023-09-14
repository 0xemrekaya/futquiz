import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
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
                            Text("Giriş yapıldı: ${FirebaseAuth.instance.currentUser!.displayName}"),
                            const SizedBox(
                              height: 25,
                            ),
                            gameOnePlayButton(context, height, width, true),
                            ElevatedButton(
                                onPressed: () {
                                  FirebaseAuth.instance.signOut();
                                },
                                child: Text("Çıkış yap")),
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
                              padding: EdgeInsets.all(height / 40),
                              child: GoogleSignInButton(
                                  size: height / 40,
                                  label: "Google ile giriş yap",
                                  loadingIndicator: const CircularProgressIndicator(),
                                  clientId: _googleId),
                            ),
                            gameOnePlayButton(context, height, width, false)
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

  ElevatedButton gameOnePlayButton(BuildContext context, double height, double width, bool isLogged) {
    return ElevatedButton(
        onPressed: isLogged
            ? () {
                Navigator.pushNamed(context, "game_one_page");
              }
            : null,
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(vertical: height / 30, horizontal: width / 5),
          ),
        ),
        child: Text(
          "Ben kimim? Oyna!",
          style: isLogged
              ? Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.primary)
              : Theme.of(context).textTheme.titleMedium!,
        ));
  }
}
