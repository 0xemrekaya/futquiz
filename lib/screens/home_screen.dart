
import 'package:flutter/material.dart';
import '../modelview/map_view_model.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void getPlayer() {
    PlayerMapViewModel player = PlayerMapViewModel();
    player.fetchPlayer("1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      children: [
        SizedBox(height: 100,),
        Center(
          child: Text("asd"),
        ),
        ElevatedButton(
          onPressed: getPlayer,
          child: Text("Get Player"),
        ),
      ],
    ));
  }
}
