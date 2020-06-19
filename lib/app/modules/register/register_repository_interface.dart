import 'package:guidelines/app/core/models/user_model.dart';

abstract class IRegisterRepository {
  Future<void> createUser(User user);
}