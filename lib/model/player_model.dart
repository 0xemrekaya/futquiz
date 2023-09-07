import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'player_model.g.dart';

@JsonSerializable(createToJson: false)
class PlayerMapModel {
  String? iD;
  String? name;
  String? fullName;
  String? age;
  String? height;
  String? weight;
  String? photoUrl;
  String? nationality;
  String? overall;
  String? positions;
  String? bestPosition;
  String? club;
  String? valueEUR;
  String? nationalTeam;
  String? preferredFoot;
  String? skillMoves;

  PlayerMapModel(
      {this.iD,
      this.name,
      this.fullName,
      this.age,
      this.height,
      this.weight,
      this.photoUrl,
      this.nationality,
      this.overall,
      this.positions,
      this.bestPosition,
      this.club,
      this.valueEUR,
      this.nationalTeam,
      this.preferredFoot,
      this.skillMoves});

  factory PlayerMapModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return _$PlayerMapModelFromJson(data!);
  }

  // Map<String, dynamic> toJson() {
  //   return _$PlayerMapModelToJson(this);
  // }
}
