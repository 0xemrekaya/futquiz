import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'player_model.g.dart';

@JsonSerializable(createToJson: false,fieldRename: FieldRename.pascal)
class PlayerMapModel {
  int? iD;
  String? name;
  String? fullName;
  int? age;
  int? height;
  int? weight;
  String? photoUrl;
  String? nationality;
  int? overall;
  String? positions;
  String? bestPosition;
  String? club;
  int? valueEUR;
  String? nationalTeam;
  String? preferredFoot;
  int? skillMoves;
  String? clubLogo;
  String? leagueLogo;

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
      this.skillMoves,
      this.clubLogo,
      this.leagueLogo
      });

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
