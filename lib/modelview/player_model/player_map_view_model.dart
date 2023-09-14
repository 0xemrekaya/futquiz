
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';

import '../../model/player_model.dart';
part 'player_map_view_model.g.dart';

class PlayerMapViewModel = _PlayerMapViewModelBase with _$PlayerMapViewModel;

abstract class _PlayerMapViewModelBase with Store {

  @observable
  PlayerMapModel? playerMapModel;

  @observable
  bool isLoading = false;

  @action
  void _changeLoading(){
    isLoading = !isLoading;
  }

  @action
  Future<void> fetchPlayer(int id) async {
    _changeLoading();
    final playersCollectionReference = FirebaseFirestore.instance.collection("player").doc(id.toString());
    final response = playersCollectionReference.withConverter(
      fromFirestore: PlayerMapModel.fromFirestore,
      toFirestore: (player, _) => {},
    );
    final players = await response.get();
    _changeLoading();
    final data = players.data(); // Convert to City object
    if (data != null) {
      playerMapModel = data;
    } else {
      print("Data is null");
    }
  }
  



}
