import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guidelines/app/core/models/guideline_model.dart';

abstract class IGuidelineRepository {
  Future<void> saveGuideline(Guideline guideline);
  Future<void> updateGuideline(Guideline guideline);
  Stream<QuerySnapshot> getGuidelines(String email);
}
