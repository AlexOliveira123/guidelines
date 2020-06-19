import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guidelines/app/core/interfaces/data_user_repository_interface.dart';

class DataUserRepository implements IDataUserRepository {
  final db;
  DataUserRepository(this.db);

  @override
  Future<DocumentSnapshot> getUserData(email) {
    return db.collection('users').document(email).get();
  }
}