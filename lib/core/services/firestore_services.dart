import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/home/data/model/program_model.dart';

class FirestoreServices{
  final FirebaseFirestore _firestoreInstance =FirebaseFirestore.instance;
  // getProgram({String? country, bool? onlyMoi}){
  //   Query query = _firestoreInstance.collection('programs');
  // }
  Future<List<ProgramModel>> getPrograms({String? country, bool? onlyMoi,String?studyField }) async {
    try {
      Query query = _firestoreInstance.collection('programs');
      if (country != null && country.isNotEmpty) {
        query = query.where('country', isEqualTo: country);
      }
      if (studyField != null && studyField.isNotEmpty) {
        query = query.where('study_field', isEqualTo: studyField);
      }
      if (onlyMoi == true) {
        query = query.where('moi_accepted', isEqualTo: true);
      }

      final snapshot = await query.get();

      return snapshot.docs.map((doc) {
        return ProgramModel.fromFirestore(doc);
      }).toList();

    } catch (e) {
      throw Exception("Failed to fetch programs: $e");
    }
  }
}