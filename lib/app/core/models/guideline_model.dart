import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:guidelines/app/core/enums/guideline_status.dart';
import 'package:guidelines/app/core/models/base_model.dart';

class Guideline extends BaseModel {
  String title;
  String briefDescription;
  String description;
  GuidelineStatus status;
  String nameUser;
  String emailUser;

  Guideline({
    this.title,
    this.briefDescription,
    this.description,
    this.status = GuidelineStatus.Open,
    this.nameUser,
    this.emailUser,
  });

  Guideline.fromDocument(DocumentSnapshot documentSnapshot): super.fromDocument(documentSnapshot) {
    title = documentSnapshot.data['title'];
    briefDescription = documentSnapshot.data['briefDescription'];
    description = documentSnapshot.data['description'];
    status = documentSnapshot.data['status'] == 'GuidelineStatus.Open'
        ? GuidelineStatus.Open
        : GuidelineStatus.Finished;
    nameUser = documentSnapshot.data['nameUser'];
    emailUser = documentSnapshot.data['emailUser'];
  }

  toJson() {
    final data = super.toJson();
    data['title'] = this.title;
    data['briefDescription'] = this.briefDescription;
    data['description'] = this.description;
    data['status'] = this.status.toString();
    data['nameUser'] = this.nameUser;
    data['emailUser'] = this.emailUser;
    return data;
  }

  copyWith({
    String title,
    String briefDescription,
    String description,
    GuidelineStatus status,
    String nameUser,
    String emailUser,
  }) {
    return Guideline(
      title: title ?? this.title,
      briefDescription: briefDescription ?? this.briefDescription,
      description: description ?? this.description,
      status: status ?? this.status,
      nameUser: nameUser ?? this.nameUser,
      emailUser: emailUser ?? this.emailUser,
    );
  }

  @override
  String toString() {
    return 'Guideline(id: $id, title: $title, briefDescription: $briefDescription, description: $description, nameUser: $nameUser, emailUser: $emailUser)';
  }
}
