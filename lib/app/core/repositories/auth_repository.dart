import 'package:firebase_auth/firebase_auth.dart';
import 'package:guidelines/app/core/interfaces/auth_repository_interface.dart';

class AuthRepository implements IAuthRepository {
  final FirebaseAuth firebaseAuth;

  AuthRepository(this.firebaseAuth);

  @override
  Future<FirebaseUser> getCurrentUser() {
    return firebaseAuth.currentUser();
  }

  @override
  Future<void> logOut() {
    return firebaseAuth.signOut();
  }

  @override
  Future<AuthResult> logIn(String email, String password) {
    return firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<AuthResult> createUser(String email, String password) {
    return firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> resetPassword(String email) {
    return firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
