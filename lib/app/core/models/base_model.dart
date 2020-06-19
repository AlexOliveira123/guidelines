import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guidelines/app/core/interfaces/base_model_interface.dart';

class BaseModel implements IBaseModel {
  //Global model, all classes will extend this model

  String id;
  bool isActive = true;
  Timestamp createdAt;
  Timestamp updatedAt;

  BaseModel();

  @override
  BaseModel.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    isActive = document.data["isActive"];
    createdAt = document.data["createdAt"];
    updatedAt = document.data["updatedAt"];
  }

  @override
  String documentId() => id;

  @override
  void disable() => isActive = false;

  @override
  void enable() => isActive = true;

  @override
  void setCreatedAt() => createdAt = Timestamp.now();

  @override
  void setUpdatedAt() => updatedAt = Timestamp.now();

  @override
  toJson() {
    var json = <String, dynamic>{};
    json['isActive'] = isActive;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;

    return json;
  }
}
