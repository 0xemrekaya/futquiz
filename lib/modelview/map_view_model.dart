import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';

import '../model/player_model.dart';
part 'map_view_model.g.dart';

class PlayerMapViewModel = _PlayerMapViewModelBase with _$PlayerMapViewModel;

abstract class _PlayerMapViewModelBase with Store {

  @observable
  PlayerMapModel? playerMapModel;

  @action
  Future<void> fetchPlayer(String id) async {
    final playersCollectionReference = await FirebaseFirestore.instance.collection("players").doc(id);
    final response = await playersCollectionReference.withConverter(
      fromFirestore: PlayerMapModel.fromFirestore,
      toFirestore: (player, _) => {},
    );
    final players = await response.get();
    final data = players.data(); // Convert to City object
    if (data != null) {
      inspect(data);
      playerMapModel = data;
    } else {
      print("Data is null");
    }
  }
}
