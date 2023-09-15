// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_modelview.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserModelView on _UserModelViewBase, Store {
  late final _$userAtom =
      Atom(name: '_UserModelViewBase.user', context: context);

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$userMapModelAtom =
      Atom(name: '_UserModelViewBase.userMapModel', context: context);

  @override
  UserMapModel? get userMapModel {
    _$userMapModelAtom.reportRead();
    return super.userMapModel;
  }

  @override
  set userMapModel(UserMapModel? value) {
    _$userMapModelAtom.reportWrite(value, super.userMapModel, () {
      super.userMapModel = value;
    });
  }

  late final _$setUserforFirstTimeAsyncAction =
      AsyncAction('_UserModelViewBase.setUserforFirstTime', context: context);

  @override
  Future<void> setUserforFirstTime() {
    return _$setUserforFirstTimeAsyncAction
        .run(() => super.setUserforFirstTime());
  }

  late final _$getUserDataAsyncAction =
      AsyncAction('_UserModelViewBase.getUserData', context: context);

  @override
  Future<void> getUserData() {
    return _$getUserDataAsyncAction.run(() => super.getUserData());
  }

  late final _$setUserDataAsyncAction =
      AsyncAction('_UserModelViewBase.setUserData', context: context);

  @override
  Future<void> setUserData(UserMapModel user) {
    return _$setUserDataAsyncAction.run(() => super.setUserData(user));
  }

  late final _$_UserModelViewBaseActionController =
      ActionController(name: '_UserModelViewBase', context: context);

  @override
  void setUser(User? user) {
    final _$actionInfo = _$_UserModelViewBaseActionController.startAction(
        name: '_UserModelViewBase.setUser');
    try {
      return super.setUser(user);
    } finally {
      _$_UserModelViewBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
userMapModel: ${userMapModel}
    ''';
  }
}
