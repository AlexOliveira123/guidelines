import 'package:guidelines/app/modules/guidelines/guidelines_module.dart';
import 'package:guidelines/app/modules/profile/profile_module.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {

  //Current page of the bottom bar widgets
  @observable
  int selectedIndex = 0;

  @action
  setSelectedIndex(idx) => selectedIndex = idx;

  @computed
  get selectedDestination => modules[selectedIndex];

  var modules = [
    GuidelinesModule(0),
    GuidelinesModule(1),
    ProfileModule(),
  ];
}
