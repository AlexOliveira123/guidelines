import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepository {
  Future<AuthResult> logIn(String email, String password);
  Future<void> logOut();
  Future<AuthResult> createUser(String email, String password);
  Future<FirebaseUser> getCurrentUser();
  Future<void> resetPassword(String email);
}
