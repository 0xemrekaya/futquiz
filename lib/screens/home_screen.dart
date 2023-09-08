import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../modelview/map_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PlayerMapViewModel player = PlayerMapViewModel();
  int? number;

  Future<void> getPlayer(int num) async {
    await player.fetchPlayer(num);
  }

  int getRandomNumber() {
    Random random = Random();
    return random.nextInt(289) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        Center(
          child: Text(
            getRandomNumber().toString(),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            number = getRandomNumber();
            getPlayer(number!);
          },
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(50),
            ),
          ),
          child: Observer(builder: (_) {
            return Column(
              children: [
                Image.network(player.playerMapModel!.photoUrl ?? "null"),
                const SizedBox(
                  height: 50,
                ),
                Text(player.playerMapModel?.name ?? "null"),
                const SizedBox(
                  height: 20,
                ),
                Text(player.playerMapModel?.fullName ?? "null"),
                const SizedBox(
                  height: 20,
                ),
                Text(player.playerMapModel?.age.toString() ?? "null"),
                const SizedBox(
                  height: 20,
                ),
                Text(player.playerMapModel?.height.toString() ?? "null"),
                const SizedBox(
                  height: 20,
                ),
                Text(player.playerMapModel?.overall.toString() ?? "null"),
                const SizedBox(
                  height: 20,
                ),
                Text(player.playerMapModel?.nationality ?? "null"),
              ],
            );
          }),
        ),
      ],
    ));
  }
}
