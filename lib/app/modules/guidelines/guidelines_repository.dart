import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guidelines/app/core/models/guideline_model.dart';
import 'package:guidelines/app/modules/guidelines/guidelines_repository_interface.dart';

class GuidelinesRepository implements IGuidelineRepository {
  final Firestore db;

  GuidelinesRepository(this.db);

  @override
  Future<void> saveGuideline(Guideline guideline) {
    guideline.setCreatedAt();
    return db
        .collection('guidelines')
        .document(guideline.id)
        .setData(guideline.toJson());
  }

  @override
  Future<void> updateGuideline(Guideline guideline) {
    guideline.setUpdatedAt();
    return db
        .collection('guidelines')
        .document(guideline.id)
        .updateData(guideline.toJson());
  }

  @override
  Stream<QuerySnapshot> getGuidelines(String email) {
    return db
        .collection('guidelines')
        .where('emailUser', isEqualTo: email)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
