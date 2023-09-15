import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:futquiz/model/user_model.dart';

class GameOneScorePage extends StatelessWidget {
  GameOneScorePage({super.key});
  static String id = "game_one_score_page";

  final ScrollController _scrollController = ScrollController();
  final _firestore = FirebaseFirestore.instance;
  List<UserMapModel>? user;

  Future<void> getScore() async {
    final users = await _firestore.collection("users").get();
    user = users.docs.map((e) => e.data()).map((e) {
      return UserMapModel(
        displayName: e["displayName"],
        userScoreGameOne: e["userScoreGameOne"],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //toolbarHeight: MediaQuery.of(context).size.height / 12,
        title: Text(
          "Ben Kimim? Oyun Skor Tablosu",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            ListTile(
                leading: Text(
                  "Sıra",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                title: Text(
                  "İsim",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                trailing: Text(
                  "Skor",
                  style: Theme.of(context).textTheme.titleMedium,
                )),
            FutureBuilder(
              future: getScore(),
              builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : user == null
                      ? const Center(child: Text("Veri Yok"))
                      : user!.isEmpty
                          ? const Center(child: Text("Veri Yok"))
                          : Expanded(
                              child: ListView.builder(
                                  controller: _scrollController,
                                  itemCount: user!.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: ListTile(
                                        leading: Text(
                                          "${index + 1}",
                                          style: Theme.of(context).textTheme.titleMedium,
                                        ),
                                        title: Text(
                                          user![index].displayName ?? "İsimsiz",
                                          style: Theme.of(context).textTheme.titleMedium,
                                        ),
                                        trailing: Text(
                                          user![index].userScoreGameOne.toString(),
                                          style: Theme.of(context).textTheme.titleMedium,
                                        ),
                                      ),
                                    );
                                  }),
                            ),
            ),
          ],
        ),
      ),
    );
  }
}
