// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMapModel _$UserMapModelFromJson(Map<String, dynamic> json) => UserMapModel(
      uid: json['uid'] as String?,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      createdAt: json['createdAt'] as String?,
      userScoreGameOne: json['userScoreGameOne'] as int?,
    );

Map<String, dynamic> _$UserMapModelToJson(UserMapModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'displayName': instance.displayName,
      'createdAt': instance.createdAt,
      'userScoreGameOne': instance.userScoreGameOne,
    };
