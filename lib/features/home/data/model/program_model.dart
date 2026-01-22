import 'package:cloud_firestore/cloud_firestore.dart';

class ProgramModel {
  final String? id;
  final String universityName;
  final String programName;
  final String country;
  final String degreeType;
  final bool moiAccepted;
  final String applyLink;
  final String ?websiteLink;
  final String? deadline;
  final String? duration;
  final String? studyField;
  final double? tuitionFees;

  ProgramModel({
    this.id,
    required this.universityName,
    required this.programName,
    required this.studyField,
    required this.country,
    required this.moiAccepted,
    required this.applyLink,
    required this.degreeType,
    required this.websiteLink,
    this.deadline,
    this.duration,
    this.tuitionFees,
  });

  factory ProgramModel.fromJson(Map<String, dynamic> json) {
    return ProgramModel(
      universityName: json['university_name'] ?? '',
      programName: json['program_name'] ?? '',
      studyField: json['study_field'] ?? '',
      degreeType: json['degree_type'] ?? '',
      country: json['country'] ?? '',
      moiAccepted: json['moi_accepted'] == true || json['moi_accepted'] == "true",
      applyLink: json['application_link'] ?? '',
      websiteLink: json['website_link'] ?? '',
      deadline: json['deadline_date'],
      duration: json['duration'],
      tuitionFees: double.tryParse(json['tuition_fees'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'university_name': universityName,
      'program_name': programName,
      'study_field': studyField,
      'degree_type': degreeType,
      'country': country,
      'moi_accepted': moiAccepted,
      'application_link': applyLink,
      'deadline_date': deadline,
      'duration': duration,
      'tuition_fees': tuitionFees,
      'created_at': FieldValue.serverTimestamp(),
    };
  }

  factory ProgramModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ProgramModel(
      id: doc.id,
      universityName: data['university_name'] ?? '',
      programName: data['program_name'] ?? '',
      studyField: data['study_field'] ?? '',
      degreeType: data['degree_type'] ?? '',
      country: data['country'] ?? '',
      moiAccepted: data['moi_accepted'] ?? false,
      applyLink: data['application_link'] ?? '',
      websiteLink: data['website_link'] ?? '',
      deadline: data['deadline_date'],
      duration: data['duration'],
      tuitionFees: (data['tuition_fees'] as num?)?.toDouble(),
    );
  }
}