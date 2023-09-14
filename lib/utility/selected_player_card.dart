import 'package:flutter/material.dart';

import '../modelview/player_model/player_map_view_model.dart';

class SelectedPlayerCard extends StatelessWidget {
  const SelectedPlayerCard({
    super.key,
    required List selectedPlayers,
    required this.index,
    required this.player,
  }) : _selectedPlayers = selectedPlayers;

  final List _selectedPlayers;
  final int index;
  final PlayerMapViewModel player;
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Card(
        child: ListTile(
            title: Text(
              "${_selectedPlayers[index]["Name"]}",
              style: textStyle.bodyMedium,
            ),
            leading: SizedBox(width: 40, child: Image.network(_selectedPlayers[index]["PhotoUrl"] ?? "")),
            trailing: SizedBox(
              width: 170,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  posAndAgeIsCorrect(context, index, textStyle, "Age"),
                  posAndAgeIsCorrect(context, index, textStyle, "BestPosition"),
                  natTeamIsCorrect(context, index, "Nationality"),
                  natTeamIsCorrect(context, index, "ClubLogo")
                ],
              ),
            )));
  }

  Container posAndAgeIsCorrect(BuildContext context, int index, TextTheme textStyle, String which) {
    String? p;
    if (which == "Age") {
      p = player.playerMapModel!.age.toString();
    } else {
      p = player.playerMapModel!.bestPosition;
    }
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: p == _selectedPlayers[index][which].toString()
            ? Colors.green[800]
            : Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Text(
          "${_selectedPlayers[index][which]}",
          style: textStyle.bodySmall,
        ),
      ),
    );
  }

  Container natTeamIsCorrect(BuildContext context, int index, String which) {
    String? p;
    if (which == "Nationality") {
      p = player.playerMapModel!.nationality;
    } else {
      p = player.playerMapModel!.clubLogo;
    }

    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: p == _selectedPlayers[index][which] ? Colors.green[800] : Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: AnimatedCrossFade(
            firstChild: const Icon(Icons.ac_unit),
            crossFadeState: CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 800),
            secondChild: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.network(_selectedPlayers[index][which]),
            )),
      ),
    );
  }
}
