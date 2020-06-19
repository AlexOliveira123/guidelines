import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guidelines/app/core/models/base_model.dart';

class User extends BaseModel {
  String name;
  String email;
  String password;

  User({this.name, this.email, this.password});

  User.fromDocument(DocumentSnapshot documentSnapshot): super.fromDocument(documentSnapshot)  {
    name = documentSnapshot.data['name'];
    email = documentSnapshot.data['email'];
  }

  toJson() {
    final data = super.toJson();
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }

  copyWith({String name, String email, String password}) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  String toString() => 'User(name: $name, email: $email, password: $password)';
}
