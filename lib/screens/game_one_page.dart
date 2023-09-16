import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:futquiz/modelview/user_modelview/user_modelview.dart';

import '../modelview/player_modelview/player_map_view_model.dart';
import '../utility/selected_player_card.dart';

class GameOnePage extends StatefulWidget {
  const GameOnePage({super.key});
  static String id = "game_one_page";

  @override
  State<GameOnePage> createState() => _GameOnePageState();
}

class _GameOnePageState extends State<GameOnePage> {
  PlayerMapViewModel player = PlayerMapViewModel();
  UserModelView user = UserModelView();
  late int number;
  final String _posImgUrl =
      "https://firebasestorage.googleapis.com/v0/b/futquiz-261d5.appspot.com/o/playing%2Fpositions.jpg?alt=media&token=876d5c8a-7188-433d-aa45-4fe0fe221da3";
  final String _tite = "Aşağıda iki ipucu verildi. Bu ipuçlarına göre futbolcuyu tahmin et!";
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  final _confettiController = ConfettiController();
  final List _selectedPlayers = [];

  @override
  void initState() {
    searchPlayer();
    number = getRandomNumber();
    getPlayer(number);
    getUserData();
    super.initState();
  }

  Future<void> getPlayer(int num) async {
    await player.fetchPlayer(num);
  }

  int getRandomNumber() {
    Random random = Random();
    return random.nextInt(274) + 1;
  }

  List _allResults = [];
  Future<void> searchPlayer() async {
    var data = await FirebaseFirestore.instance.collection("player").orderBy("Name").get();
    setState(() {
      _allResults = data.docs;
    });
  }

  void _skipPlayer() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      width: 200,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
      content: Center(child: Text("Futbolcu değiştirildi!")),
      duration: Duration(milliseconds: 1000),
    ));
    number = getRandomNumber();
    getPlayer(number);
    if (user.userMapModel!.userScoreGameOne! > 5) {
      user.userMapModel!.userScoreGameOne = user.userMapModel!.userScoreGameOne! - 5;
      user.setUserData(user.userMapModel!);
    }

    setState(() {
      _selectedPlayers.clear();
      searchPlayer();
      _scrollController.jumpTo(0);
    });
  }

  void _showPlayer(double height, double width, TextTheme textStyle) {
    showDialog(
        context: context,
        builder: (context) => Padding(
              padding: EdgeInsets.symmetric(vertical: height / 5, horizontal: width / 30),
              child: Dialog(
                backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                child: Observer(builder: (_) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Text("Bilemediğiniz futbolcu", style: textStyle.headlineSmall),
                      Container(
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                        child: Image.network(
                          player.playerMapModel?.photoUrl.toString() ?? "null",
                          height: 200,
                        ),
                      ),
                      Text(player.playerMapModel?.name.toString() ?? "null"),
                      Text(player.playerMapModel?.fullName.toString() ?? "null"),
                      Text(player.playerMapModel?.age.toString() ?? "null"),
                      Text(
                        "${player.playerMapModel!.positions},${player.playerMapModel!.bestPosition}",
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          infoAboutPlayer("Kulüp", player.playerMapModel?.clubLogo.toString(), true),
                          infoAboutPlayer("Lig", player.playerMapModel?.leagueLogo.toString(), true),
                          infoAboutPlayer("Bayrak", player.playerMapModel?.nationality.toString(), true),
                          // Image.network(height: 25, player.playerMapModel?.clubLogo.toString() ?? "null"),
                          // Image.network(
                          //     height: 30,
                          //     color: Theme.of(context).colorScheme.secondaryContainer,
                          //     colorBlendMode: BlendMode.colorBurn,
                          //     player.playerMapModel?.leagueLogo.toString() ?? "null"),
                          // Image.network(height: 25, player.playerMapModel?.nationality.toString() ?? "null")
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                }),
              ),
            )).then((value) {
      _skipPlayer();
    });
  }

  Future<void> getUserData() async {
    await user.getUserData();
  }

  int calculatePoint() {
    if (_selectedPlayers.length == 1) {
      return 10;
    } else if (_selectedPlayers.length == 2) {
      return 8;
    } else if (_selectedPlayers.length == 3) {
      return 6;
    } else if (_selectedPlayers.length == 4) {
      return 4;
    } else if (_selectedPlayers.length == 5) {
      return 2;
    } else {
      return 0;
    }
  }

  void _correct(String id) {
    int point = calculatePoint();
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
                    title: Text("Tebrikler, doğru bildiniz! \n $point puan kazandınız!"),
                    actions: [
                      FilledButton(
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
    user.userMapModel!.userScoreGameOne = user.userMapModel!.userScoreGameOne! + point;
    user.setUserData(user.userMapModel!);
    setState(() {
      _selectedPlayers.clear();
      searchPlayer();
      _scrollController.jumpTo(0);
    });
  }

  Future<List<String>> _fetchSuggestions(String searchValue) async {
    List<String> suggestions = _allResults.map((e) => "${e["Name"]}, ${e["FullName"]}").toList();
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
      appBar: _appBar(context, height, width),
      body: Scrollbar(
        thumbVisibility: true,
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
                  _tite,
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
                        infoAboutPlayer("Yaş", player.playerMapModel?.age.toString(), false),
                        infoAboutPlayer("Lig", player.playerMapModel?.leagueLogo.toString(), true),
                        infoAboutPlayer("Mevki", player.playerMapModel?.bestPosition.toString(), false),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height / 20, horizontal: width / 15),
                      child: SizedBox(
                        height: 50,
                        width: 300,
                        child: searchingPlayer(textStyle),
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
                                return SelectedPlayerCard(
                                  selectedPlayers: _selectedPlayers,
                                  index: index,
                                  player: player,
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Observer(builder: (_) {
                  return Text("Toplam puanınız: ${user.userMapModel?.userScoreGameOne ?? 0}");
                }),
                ElevatedButton(
                    onPressed: () {
                      _skipPlayer();
                    },
                    child: const Text("Futbolcuyu değiştir")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column infoAboutPlayer(String text, String? data, bool image) {
    return Column(
      children: [
        Text(text),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: image ? Colors.white : Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: Observer(builder: (_) {
            return image
                ? data == null
                    ? const Icon(Icons.image_not_supported, size: 40)
                    : Image.network(
                        data,
                        height: 40,
                        color: Colors.white,
                        colorBlendMode: BlendMode.colorBurn,
                      )
                : Text(data ?? "null");
          })),
        ),
      ],
    );
  }

  EasyAutocomplete searchingPlayer(TextTheme textStyle) {
    return EasyAutocomplete(
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
            if ("${element["Name"]}, ${element["FullName"]}" == p0) {
              _selectedPlayers.add(element);
              _searchController.clear();
            }
          }
          String id = player.playerMapModel!.iD.toString();
          if (_selectedPlayers.map((e) => "${e["ID"]}").contains(id)) {
            _correct(id);
            _confettiController.play();
          }
          if (_selectedPlayers.length == 6) {
            _showPlayer(MediaQuery.of(context).size.height, MediaQuery.of(context).size.width, textStyle);
          }
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.linear,
          );
          setState(() {
            _allResults.removeWhere((element) => _selectedPlayers.contains(element));
          });
        },
        decoration: InputDecoration(
          labelText: "Futbolcu ara, kalan hak: ${6 - _selectedPlayers.length}",
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(style: BorderStyle.solid)),
        ),
        suggestionBackgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        suggestionBuilder: (data) {
          return Card(
            child: Container(
                width: 250,
                margin: const EdgeInsets.all(1),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondary, borderRadius: BorderRadius.circular(5)),
                child: Text(data, style: textStyle.bodyMedium)),
          );
        });
  }

  AppBar _appBar(BuildContext context, double height, double width) {
    return AppBar(
      title: const Align(
          alignment: Alignment.center,
          child: Text(
            "Ben Kimim?",
          )),
      actions: [
        IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => Padding(
                      padding: EdgeInsets.symmetric(vertical: height / 5, horizontal: width / 30),
                      child: Dialog(
                        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text("Oyuncu pozisyon bilgilendirmesi"),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.network(
                                _posImgUrl,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
          },
          icon: const Icon(
            Icons.info_outline_rounded,
          ),
        ),
      ],
    );
  }
}
