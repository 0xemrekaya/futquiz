import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../modelview/map_view_model.dart';

class GameOnePage extends StatefulWidget {
  const GameOnePage({super.key});
  static String id = "game_one_page";

  @override
  State<GameOnePage> createState() => _GameOnePageState();
}

class _GameOnePageState extends State<GameOnePage> {
  PlayerMapViewModel player = PlayerMapViewModel();
  late int number;
  final _searchController = TextEditingController();

  @override
  void initState() {
    number = getRandomNumber();
    getPlayer(number);
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    searchPlayer();
    super.didChangeDependencies();
  }

  Future<void> getPlayer(int num) async {
    await player.fetchPlayer(num);
  }

  int getRandomNumber() {
    Random random = Random();
    return random.nextInt(289) + 1;
  }

  List _allResults = [];
  List _resultList = [];

  Future<void> searchPlayer() async {
    var data = await FirebaseFirestore.instance.collection("players").orderBy("Name").get();
    setState(() {
      _allResults = data.docs;
    });
    searchResultList();
  }

  void _onSearchChanged() {
    searchResultList();
  }

  void searchResultList() {
    var showResults = [];
    if (_searchController.text != "") {
      for (var players in _allResults) {
        var name = players["Name"].toString().toLowerCase();
        if (name.contains(_searchController.text.toLowerCase())) {
          showResults.add(players);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultList = showResults;
    });
  }

  // This is not using at now because it doesnt work with ui design at now.
  // List<String> getRandomProperties(
  //     String age, String height, String nationality, String positions, String preferredFoot) {
  //   List properties = [age, height, nationality, positions, preferredFoot];
  //   final random = Random();
  //   final selectedProperties = <String>[];
  //   while (selectedProperties.length < 2) {
  //     final index = random.nextInt(properties.length);
  //     final property = properties[index];
  //     if (property != null && !selectedProperties.contains(property)) {
  //       selectedProperties.add(property);
  //     }
  //   }
  //   return selectedProperties;
  // }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      appBar: _appBar(context),
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height / 20,
            horizontal: width / 10,
          ),
          child: Column(
            children: [
              Text(
                "Aşağıda iki ipucu verildi. Bu ipuçlarına göre futbolcuyu tahmin et!",
                textAlign: TextAlign.center,
                style: textStyle.titleMedium,
              ),
              SizedBox(
                height: height / 40,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text("Yaşı"),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xAA1737EB),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(child: Observer(builder: (_) {
                              return Text(player.playerMapModel?.age.toString() ?? "null");
                            })),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("Pozisyonu"),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xAA1737EB),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(child: Observer(builder: (_) {
                              return Text(player.playerMapModel?.bestPosition ?? "null");
                            })),
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height / 20, horizontal: width / 15),
                    child: SizedBox(
                      width: 200,
                      height: 50,
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "Tahmin et",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.blueAccent,
                    height: 100,
                    child: ListView.builder(
                      itemCount: _resultList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_resultList[index]["Name"]),
                          subtitle: Text(_resultList[index]["Age"].toString()),
                        );
                      },
                    ),
                  ),
                  Observer(builder: (_) {
                    return Text(player.playerMapModel?.name ?? "null");
                  }),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              ElevatedButton(
                  onPressed: () {
                    number = getRandomNumber();
                    getPlayer(number);
                  },
                  child: const Text("Skip")),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Align(
          alignment: Alignment.center,
          child: Text(
            "Ben Kimim?",
          )),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, "home_page");
          },
          icon: const Icon(Icons.exit_to_app_rounded),
        ),
      ],
    );
  }
}
