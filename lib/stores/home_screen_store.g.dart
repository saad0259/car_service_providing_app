// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeScreenStore on _HomeScreenStore, Store {
  late final _$isLoadingHomeScreenDataAtom =
      Atom(name: '_HomeScreenStore.isLoadingHomeScreenData', context: context);

  @override
  bool get isLoadingHomeScreenData {
    _$isLoadingHomeScreenDataAtom.reportRead();
    return super.isLoadingHomeScreenData;
  }

  @override
  set isLoadingHomeScreenData(bool value) {
    _$isLoadingHomeScreenDataAtom
        .reportWrite(value, super.isLoadingHomeScreenData, () {
      super.isLoadingHomeScreenData = value;
    });
  }

  late final _$currentUserAtom =
      Atom(name: '_HomeScreenStore.currentUser', context: context);

  @override
  ServiceShop get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(ServiceShop value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$loadAllDataAsyncAction =
      AsyncAction('_HomeScreenStore.loadAllData', context: context);

  @override
  Future<void> loadAllData() {
    return _$loadAllDataAsyncAction.run(() => super.loadAllData());
  }

  @override
  String toString() {
    return '''
isLoadingHomeScreenData: ${isLoadingHomeScreenData},
currentUser: ${currentUser}
    ''';
  }
}
