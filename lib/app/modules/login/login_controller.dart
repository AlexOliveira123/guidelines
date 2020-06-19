import 'package:flutter_modular/flutter_modular.dart';
import 'package:guidelines/app/core/stores/auth/auth_store.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  AuthStore auth = Modular.get();

  @observable
  bool isLoading = false;

  @observable
  String email;

  @observable
  String password;

  @observable
  bool obscurePassword = true;

  @action
  onChangedEmail(value) => email = value;

  @action
  onChangedPassword(value) => password = value;

  @action
  setObscurePassword() => obscurePassword = !obscurePassword;

  //function to do login in the app
  @action
  Future<dynamic> logIn() async {
    isLoading = true;

    try {
      var user = await auth.logIn(email, password);
      isLoading = false;

      print('user: $user');

      return user;
    } catch (error) {
      print('logIn - $error');
      return error.code;
    }
  }

  //function that send an email to reset the user pwd
  Future<dynamic> resetPassword() async {
    isLoading = true;

    try {
      await auth.resetPassword(email);

      return true;
    } catch (error) {

      print('resetPassword - $error');
      return error.code;
    }
  }
}
