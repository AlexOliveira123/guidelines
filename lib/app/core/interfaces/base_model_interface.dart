import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IBaseModel {
  String documentId(); 

  Map toJson(); 

  IBaseModel();

  IBaseModel.fromDocument(DocumentSnapshot document);

  void disable();

  void enable();

  void setCreatedAt();

  void setUpdatedAt();
}