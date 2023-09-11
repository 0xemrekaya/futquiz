import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
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
  final _scrollController = ScrollController();
  final _confettiController = ConfettiController();
  List _selectedPlayers = [];

  @override
  void initState() {
    searchPlayer();
    number = getRandomNumber();
    getPlayer(number);
    super.initState();
  }

  Future<void> getPlayer(int num) async {
    await player.fetchPlayer(num);
  }

  int getRandomNumber() {
    Random random = Random();
    return random.nextInt(289) + 1;
  }

  List _allResults = [];
  Future<void> searchPlayer() async {
    var data = await FirebaseFirestore.instance.collection("new").orderBy("Name").get();
    setState(() {
      _allResults = data.docs;
    });
  }

//${element["Name"]} - ${element["Club"]}
  void _correct(String id) {
    showDialog(
        context: context,
        builder: (context) => Stack(
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: ConfettiWidget(
                      confettiController: _confettiController,
                      shouldLoop: false,
                      blastDirectionality: BlastDirectionality.explosive,
                      numberOfParticles: 50,
                    ),
                  ),
                ),
                Center(
                  child: AlertDialog(
                    title: const Text("Tebrikler, doğru bildiniz!"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Tamam"),
                      ),
                    ],
                  ),
                )
              ],
            ));
    number = getRandomNumber();
    getPlayer(number);
    setState(() {
      _selectedPlayers.clear();
      searchPlayer();
      _scrollController.jumpTo(0);
    });
  }

  Future<List<String>> _fetchSuggestions(String searchValue) async {
    List<String> suggestions = _allResults.map((e) => "${e["Name"]} - ${e["Club"]}").toList();
    List<String> filteredSuggestions = suggestions.where((element) {
      return element.toLowerCase().contains(searchValue.toLowerCase());
    }).toList();
    return filteredSuggestions;
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

  // bool _isContainerVisible = false;

  @override
  void dispose() {
    _confettiController.dispose();
    _scrollController.dispose();
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
      body: Scrollbar(
        isAlwaysShown: true,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height / 50,
          ),
          child: SingleChildScrollView(
            controller: _scrollController,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                        height: 50,
                        width: 250,
                        child: EasyAutocomplete(
                            controller: _searchController,
                            progressIndicatorBuilder: const CircularProgressIndicator(),
                            asyncSuggestions: (searchValue) async {
                              return _fetchSuggestions(searchValue);
                            },
                            // suggestions: _searchController.text.isEmpty
                            //     ? []
                            //     : _allResults.map((e) => e["Name"].toString() + " - " + e["Club"].toString()).toList(),
                            onSubmitted: (p0) {
                              for (var element in _allResults) {
                                if ("${element["Name"]} - ${element["Club"]}" == p0) {
                                  _selectedPlayers.add(element);
                                  _searchController.clear();
                                }
                              }
                              String id = player.playerMapModel!.iD.toString();
                              if (_selectedPlayers.map((e) => "${e["ID"]}").contains(id)) {
                                _correct(id);
                                _confettiController.play();
                              }
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOut,
                              );
                              setState(() {
                                _allResults.removeWhere((element) => _selectedPlayers.contains(element));
                              });
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(style: BorderStyle.solid)),
                            ),
                            suggestionBuilder: (data) {
                              return Container(
                                  width: 250,
                                  margin: const EdgeInsets.all(3),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(218, 154, 226, 177),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(data, style: const TextStyle(color: Colors.white)));
                            }),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: SizedBox(
                            height: 80 * _selectedPlayers.length.toDouble(),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _selectedPlayers.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 70,
                                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(218, 154, 226, 177),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: ListTile(
                                      title: Text("${_selectedPlayers[index]["Name"]}"),
                                      leading: Image.network(_selectedPlayers[index]["PhotoUrl"] ?? ""),
                                      subtitle: Text("${_selectedPlayers[index]["Club"]}"),
                                      trailing: Image.network(_selectedPlayers[index]["Nationality"] ?? "")),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: height / 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      number = getRandomNumber();
                      getPlayer(number);
                    },
                    child: const Text("Skip")),
                Observer(builder: (_) {
                  return Text(player.playerMapModel?.name ?? "null");
                }),
              ],
            ),
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
