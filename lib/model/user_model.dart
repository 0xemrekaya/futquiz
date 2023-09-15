import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(createToJson: true)
class UserMapModel {
  String? uid;
  String? email;
  String? displayName;
  String? createdAt;
  int? userScoreGameOne;

  UserMapModel({
    this.uid,
    this.email,
    this.displayName,
    this.createdAt,
    this.userScoreGameOne,
  });

  factory UserMapModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return _$UserMapModelFromJson(data!);
  }

  Map<String, dynamic> toFirestore() {
    return _$UserMapModelToJson(this);
  }
}
