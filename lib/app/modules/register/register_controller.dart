import 'package:flutter_modular/flutter_modular.dart';
import 'package:guidelines/app/core/models/user_model.dart';
import 'package:guidelines/app/core/stores/auth/auth_store.dart';
import 'package:guidelines/app/modules/register/register_repository_interface.dart';
import 'package:mobx/mobx.dart';
part 'register_controller.g.dart';

class RegisterController = _RegisterControllerBase with _$RegisterController;

abstract class _RegisterControllerBase with Store {
  AuthStore auth = Modular.get();
  IRegisterRepository _registerRepository = Modular.get();

  @observable
  User user = User();

  //variable to show or not the password in the field
  @observable
  bool passwordObscure = true;


  //variable to show a loader when the app send the data to database
  @observable
  bool isLoading = false;

  //function that get input data and set in the object 'User'
  @action
  setUserData({name, email, password}) {
    user = user.copyWith(name: name, email: email, password: password);

    print('${user.name}, ${user.email}, ${user.password}');
  }

  @action
  setPasswordObscure() => passwordObscure = !passwordObscure;

  //function to create a new user in the app
  Future<dynamic> createUser() async {
    isLoading = true;
    var email = user.email.trim();
    var password = user.password.trim();

    try {
      //save the data in firebaseAuth 
      var firebaseUser = await auth.createUser(email, password);
      
      if (firebaseUser != null) {
        //save the data in Cloud firestore
        await _registerRepository.createUser(user);
      }

      return true;
    } catch (error) {
      print('error on create new user $error');
      return error.code;
    }
  }
}
