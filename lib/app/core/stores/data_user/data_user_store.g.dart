// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DataUserStore on _DataUserStoreBase, Store {
  final _$userAtom = Atom(name: '_DataUserStoreBase.user');

  @override
  User get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$getUserDataAsyncAction =
      AsyncAction('_DataUserStoreBase.getUserData');

  @override
  Future<void> getUserData() {
    return _$getUserDataAsyncAction.run(() => super.getUserData());
  }

  @override
  String toString() {
    return '''
user: ${user}
    ''';
  }
}
