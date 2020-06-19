import 'package:guidelines/app/core/models/user_model.dart';
import 'package:guidelines/app/modules/register/register_repository_interface.dart';

class RegisterRepository implements IRegisterRepository {
  final db;

  RegisterRepository(this.db);

  @override
  Future<void> createUser(User user) {
    user.setCreatedAt();
    return db
        .collection('users')
        .document(user.email)
        .setData(user.toJson());
  }
}
