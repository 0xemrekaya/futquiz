import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static String id = "home_page";

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
                    style: textStyle.headlineLarge,
                    textAlign: TextAlign.start,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "game_one_page");
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(vertical: height / 50, horizontal: width / 10),
                      ),
                    ),
                    child: const Text("Ben kimim? Oyna!")),
                SizedBox(height: height / 10),
                Text(description, style: textStyle.bodySmall, textAlign: TextAlign.center),
              ],
            )),
      )),
    );
  }
}
