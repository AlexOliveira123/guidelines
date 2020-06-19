// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RegisterController on _RegisterControllerBase, Store {
  final _$userAtom = Atom(name: '_RegisterControllerBase.user');

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

  final _$passwordObscureAtom =
      Atom(name: '_RegisterControllerBase.passwordObscure');

  @override
  bool get passwordObscure {
    _$passwordObscureAtom.reportRead();
    return super.passwordObscure;
  }

  @override
  set passwordObscure(bool value) {
    _$passwordObscureAtom.reportWrite(value, super.passwordObscure, () {
      super.passwordObscure = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_RegisterControllerBase.isLoading');

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

  final _$_RegisterControllerBaseActionController =
      ActionController(name: '_RegisterControllerBase');

  @override
  dynamic setUserData({dynamic name, dynamic email, dynamic password}) {
    final _$actionInfo = _$_RegisterControllerBaseActionController.startAction(
        name: '_RegisterControllerBase.setUserData');
    try {
      return super.setUserData(name: name, email: email, password: password);
    } finally {
      _$_RegisterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPasswordObscure() {
    final _$actionInfo = _$_RegisterControllerBaseActionController.startAction(
        name: '_RegisterControllerBase.setPasswordObscure');
    try {
      return super.setPasswordObscure();
    } finally {
      _$_RegisterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
passwordObscure: ${passwordObscure},
isLoading: ${isLoading}
    ''';
  }
}
