import 'package:flutter_modular/flutter_modular.dart';
import 'package:guidelines/app/core/models/user_model.dart';
import 'package:guidelines/app/core/stores/auth/auth_store.dart';
import 'package:guidelines/app/core/stores/data_user/data_user_store.dart';
import 'package:mobx/mobx.dart';
part 'profile_controller.g.dart';

class ProfileController = _ProfileControllerBase with _$ProfileController;

abstract class _ProfileControllerBase with Store {
  AuthStore auth = Modular.get();
  DataUserStore dataUserStore = Modular.get();

  _ProfileControllerBase() {
    getUser();
  }

  @observable
  User user;
  
  //function to get the user's data
  @action
  getUser() {
    user = dataUserStore.user;
  }
  
  //logOut user
  Future<void> logOut() async {
    try {
      await auth.logOut();
    } catch (error) {
      print('logOut - $error');
    }
  }
}
