import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:study_path/core/services/firestore_services.dart';

import '../../data/model/program_model.dart';

part 'programs_state.dart';

class ProgramsCubit extends Cubit<ProgramsState> {
  ProgramsCubit() : super(ProgramsInitial());
  final FirebaseFirestore _firestoreInstance =FirebaseFirestore.instance;


  getPrograms({required String country, bool? onlyMoi,required String studyField ,required String degreeType }) async {
    emit(ProgramsLoading());
    try {
      Query query = _firestoreInstance.collection('programs');
      if (country.isNotEmpty) {
        query = query.where('country', isEqualTo: country);
      }
      if (studyField.isNotEmpty) {
        query = query.where('study_field', isEqualTo: studyField);
      }
      if (degreeType.isNotEmpty) {
        query = query.where('degree_type', isEqualTo: degreeType);
      }
      if (onlyMoi == true) {
        query = query.where('moi_accepted', isEqualTo: true);
      }
      else{
        query = query.where('moi_accepted', isEqualTo: false);
      }

      final snapshot = await query.get();

      var programs = snapshot.docs.map((doc) {
        return ProgramModel.fromFirestore(doc);
      }).toList();
      // return snapshot.docs.map((doc) {
      //   return ProgramModel.fromFirestore(doc);
      // }).toList();
      if (programs.isEmpty) {
        emit(ProgramsLoadEmpty(programs));
      } else{
        emit(ProgramsLoaded(programs));
      }
      // return programs;

    } catch (e) {
      emit(ProgramsError(errorMsg: e.toString()));
    }
  }
}
