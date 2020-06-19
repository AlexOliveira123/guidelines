import 'package:firebase_auth/firebase_auth.dart';
import 'package:guidelines/app/core/enums/auth_status.dart';
import 'package:guidelines/app/core/interfaces/auth_repository_interface.dart';
import 'package:mobx/mobx.dart';
part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {  
  //Defined as global so that it can be recovered anywhere
  //Global class to authenticate the user.

  final IAuthRepository authRepository;

  //Getting the current user logged in the app
  _AuthStoreBase(this.authRepository) {
    authRepository.getCurrentUser().then(getUser);
  }

  @observable
  AuthStatus authStatus = AuthStatus.Loading;

  @observable
  FirebaseUser user;

  @action
  getUser(FirebaseUser currentUser){
    print('currentUser ${currentUser?.email}');
    user = currentUser;
    authStatus = user == null ? AuthStatus.Disconnected : AuthStatus.Logged;
  }

  //function to logIn the user
  Future<FirebaseUser> logIn(email, password) async {
    var authResult = await authRepository.logIn(
      email,
      password,
    );

    user = authResult.user;

    return user;
  }

  //function to create an user in the firebaseAuth
  Future<FirebaseUser> createUser(email, password) async {
    var authResult  = await authRepository.createUser(
      email,
      password,
    );

    user = authResult.user;

    return user;
  }

  //function to send an email to reset the user password
  Future<void> resetPassword(email) async {
    await authRepository.resetPassword(email);
  }

  //function logout;
  Future<void> logOut() async {
    await authRepository.logOut();
  }
}
