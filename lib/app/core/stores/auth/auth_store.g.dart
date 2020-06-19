// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStoreBase, Store {
  final _$authStatusAtom = Atom(name: '_AuthStoreBase.authStatus');

  @override
  AuthStatus get authStatus {
    _$authStatusAtom.reportRead();
    return super.authStatus;
  }

  @override
  set authStatus(AuthStatus value) {
    _$authStatusAtom.reportWrite(value, super.authStatus, () {
      super.authStatus = value;
    });
  }

  final _$userAtom = Atom(name: '_AuthStoreBase.user');

  @override
  FirebaseUser get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(FirebaseUser value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$_AuthStoreBaseActionController =
      ActionController(name: '_AuthStoreBase');

  @override
  dynamic getUser(FirebaseUser currentUser) {
    final _$actionInfo = _$_AuthStoreBaseActionController.startAction(
        name: '_AuthStoreBase.getUser');
    try {
      return super.getUser(currentUser);
    } finally {
      _$_AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
authStatus: ${authStatus},
user: ${user}
    ''';
  }
}
