// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PlayerMapViewModel on _PlayerMapViewModelBase, Store {
  late final _$playerMapModelAtom =
      Atom(name: '_PlayerMapViewModelBase.playerMapModel', context: context);

  @override
  PlayerMapModel? get playerMapModel {
    _$playerMapModelAtom.reportRead();
    return super.playerMapModel;
  }

  @override
  set playerMapModel(PlayerMapModel? value) {
    _$playerMapModelAtom.reportWrite(value, super.playerMapModel, () {
      super.playerMapModel = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_PlayerMapViewModelBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$fetchPlayerAsyncAction =
      AsyncAction('_PlayerMapViewModelBase.fetchPlayer', context: context);

  @override
  Future<void> fetchPlayer(int id) {
    return _$fetchPlayerAsyncAction.run(() => super.fetchPlayer(id));
  }

  late final _$_PlayerMapViewModelBaseActionController =
      ActionController(name: '_PlayerMapViewModelBase', context: context);

  @override
  void _changeLoading() {
    final _$actionInfo = _$_PlayerMapViewModelBaseActionController.startAction(
        name: '_PlayerMapViewModelBase._changeLoading');
    try {
      return super._changeLoading();
    } finally {
      _$_PlayerMapViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
playerMapModel: ${playerMapModel},
isLoading: ${isLoading}
    ''';
  }
}
