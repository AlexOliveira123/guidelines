import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IDataUserRepository {
  Future<DocumentSnapshot> getUserData(email);
}
