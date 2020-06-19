// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guidelines_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GuidelinesController on _GuidelinesControllerBase, Store {
  Computed<bool> _$buttonEnabledComputed;

  @override
  bool get buttonEnabled =>
      (_$buttonEnabledComputed ??= Computed<bool>(() => super.buttonEnabled,
              name: '_GuidelinesControllerBase.buttonEnabled'))
          .value;

  final _$guidelineAtom = Atom(name: '_GuidelinesControllerBase.guideline');

  @override
  Guideline get guideline {
    _$guidelineAtom.reportRead();
    return super.guideline;
  }

  @override
  set guideline(Guideline value) {
    _$guidelineAtom.reportWrite(value, super.guideline, () {
      super.guideline = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_GuidelinesControllerBase.isLoading');

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

  final _$isChangingAtom = Atom(name: '_GuidelinesControllerBase.isChanging');

  @override
  bool get isChanging {
    _$isChangingAtom.reportRead();
    return super.isChanging;
  }

  @override
  set isChanging(bool value) {
    _$isChangingAtom.reportWrite(value, super.isChanging, () {
      super.isChanging = value;
    });
  }

  final _$guidelinesAtom = Atom(name: '_GuidelinesControllerBase.guidelines');

  @override
  ObservableList<dynamic> get guidelines {
    _$guidelinesAtom.reportRead();
    return super.guidelines;
  }

  @override
  set guidelines(ObservableList<dynamic> value) {
    _$guidelinesAtom.reportWrite(value, super.guidelines, () {
      super.guidelines = value;
    });
  }

  final _$_GuidelinesControllerBaseActionController =
      ActionController(name: '_GuidelinesControllerBase');

  @override
  void setGuideline(
      {dynamic title, dynamic briefDescription, dynamic description}) {
    final _$actionInfo = _$_GuidelinesControllerBaseActionController
        .startAction(name: '_GuidelinesControllerBase.setGuideline');
    try {
      return super.setGuideline(
          title: title,
          briefDescription: briefDescription,
          description: description);
    } finally {
      _$_GuidelinesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
guideline: ${guideline},
isLoading: ${isLoading},
isChanging: ${isChanging},
guidelines: ${guidelines},
buttonEnabled: ${buttonEnabled}
    ''';
  }
}
