import 'package:flutter_modular/flutter_modular.dart';
import 'package:guidelines/app/core/interfaces/data_user_repository_interface.dart';
import 'package:guidelines/app/core/models/user_model.dart';
import 'package:guidelines/app/core/stores/auth/auth_store.dart';
import 'package:mobx/mobx.dart';
part 'data_user_store.g.dart';

class DataUserStore = _DataUserStoreBase with _$DataUserStore;

abstract class _DataUserStoreBase with Store {
  //Defined as global so that it can be recovered anywhere
  //Global class to get the user data.

  final IDataUserRepository dataUserRepository;
  AuthStore auth = Modular.get();

  _DataUserStoreBase(this.dataUserRepository) {
    getUserData();
  }

  @observable
  User user;

  //function to get the user data in database
  //and set in the 'User' object, which will
  //available for the entire application
  @action
  Future<void> getUserData() async {
    var email = auth.user.email;
    try {
      var documentSnapshot = await dataUserRepository.getUserData(email);
      user = User.fromDocument(documentSnapshot);

    } catch (error) {
      print('getDataUser - $error');
      return null;
    }
  }
}
