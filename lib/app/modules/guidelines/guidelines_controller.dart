import 'dart:math';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:guidelines/app/core/models/guideline_model.dart';
import 'package:guidelines/app/core/stores/auth/auth_store.dart';
import 'package:guidelines/app/core/stores/data_user/data_user_store.dart';
import 'package:guidelines/app/modules/guidelines/guidelines_repository_interface.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';

part 'guidelines_controller.g.dart';

class GuidelinesController = _GuidelinesControllerBase with _$GuidelinesController;

abstract class _GuidelinesControllerBase with Store {
  IGuidelineRepository _guidelineRepository = Modular.get();
  DataUserStore _dataUserStore = Modular.get();
  AuthStore _authStore = Modular.get();

  @observable
  Guideline guideline = Guideline();

  //variable to show a loader when the app is loading the guidelines
  //or added a new guideline
  @observable
  bool isLoading = false;

  //variable to show a loader when the user is 
  //reopening and finishing the guidelines
  @observable
  bool isChanging = false;

  //array that will contains the guidelines
  //added by user
  @observable
  ObservableList guidelines;

  @observable
  int expanded = -1;

  //Condition to enable the button 'Finalizar' on page 'Incluir pauta'
  @computed
  bool get buttonEnabled =>
      guideline.title != null &&
      guideline.briefDescription != null &&
      guideline.description != null &&
      guideline.title.trim().length > 0 &&
      guideline.briefDescription.trim().length > 0 &&
      guideline.description.trim().length > 0;

  //function to set the data of the new guideline
  @action
  void setGuideline({title, briefDescription, description}) {
    guideline = guideline.copyWith(
      title: title,
      briefDescription: briefDescription,
      description: description,
    );

    print('title: ${guideline.title}, briefDescription: ${guideline.briefDescription}, description: ${guideline.description}');
  }

  //function to save the guideline data in database
  Future<dynamic> saveGuideline() async {
    isLoading = true;
    guideline.id = Uuid().v1();
    guideline.nameUser = _dataUserStore.user.name;
    guideline.emailUser = _dataUserStore.user.email;

    try {
      await _guidelineRepository.saveGuideline(guideline);

      return guideline.id;
    } catch (error) {
      print('error on save the guideline $error');
    }
  }

  //function to update the guideline data in database
  updateGuideline(Guideline guideline) async {
    isChanging = true;
    await Future.delayed(Duration(milliseconds: 350));

    try {
      await _guidelineRepository.updateGuideline(guideline);

    } catch (error) {
      print('error on update the guideline $error');
    }
  }

  //A stream function that will listen and add the guidelines in array.
  getGuidelines() {
    var email = _authStore.user?.email;
    try {
      var stream = _guidelineRepository.getGuidelines(email);

      stream.listen((data) {
        var documentsGuidelines = data.documents;

        guidelines = documentsGuidelines
            .map((guideline) => Guideline.fromDocument(guideline))
            .toList()
            .asObservable();
      });
      
    } catch (error) {
      print('Error on get the guidelines $error');
    }
  }
}
