import 'package:cloud_firestore/cloud_firestore.dart';

// class ProgramModel {
//   final String? id;
//   final String universityName;
//   final String programName;
//   final String country;
//   final String degreeType;
//   final bool moiAccepted;
//   final String applyLink;
//   final String ?websiteLink;
//   final String? deadline;
//   final String? duration;
//   final String? studyField;
//   final double? tuitionFees;
//
//   ProgramModel({
//     this.id,
//     required this.universityName,
//     required this.programName,
//     required this.studyField,
//     required this.country,
//     required this.moiAccepted,
//     required this.applyLink,
//     required this.degreeType,
//     required this.websiteLink,
//     this.deadline,
//     this.duration,
//     this.tuitionFees,
//   });
//
//   factory ProgramModel.fromJson(Map<String, dynamic> json, {String? docId}) {
//     return ProgramModel(
//       id: docId ?? json['id'],
//       universityName: json['university_name'] ?? '',
//       programName: json['program_name'] ?? '',
//       studyField: json['study_field'] ?? '',
//       degreeType: json['degree_type'] ?? '',
//       country: json['country'] ?? '',
//       moiAccepted: json['moi_accepted'] == true || json['moi_accepted'] == "true",
//       applyLink: json['application_link'] ?? '',
//       websiteLink: json['website_link'] ?? '',
//       deadline: json['deadline_date'],
//       duration: json['duration'],
//       tuitionFees: double.tryParse(json['tuition_fees'].toString()),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'university_name': universityName,
//       'program_name': programName,
//       'study_field': studyField,
//       'degree_type': degreeType,
//       'country': country,
//       'moi_accepted': moiAccepted,
//       'application_link': applyLink,
//       'website_link': websiteLink,
//       'deadline_date': deadline,
//       'duration': duration,
//       'tuition_fees': tuitionFees,
//       // 'created_at': FieldValue.serverTimestamp(),
//     };
//   }
//
//   factory ProgramModel.fromFirestore(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//     return ProgramModel(
//       id: doc.id,
//       universityName: data['university_name'] ?? '',
//       programName: data['program_name'] ?? '',
//       studyField: data['study_field'] ?? '',
//       degreeType: data['degree_type'] ?? '',
//       country: data['country'] ?? '',
//       moiAccepted: data['moi_accepted'] ?? false,
//       applyLink: data['application_link'] ?? '',
//       websiteLink: data['website_link'] ?? '',
//       deadline: data['deadline_date'],
//       duration: data['duration'],
//       tuitionFees: (data['tuition_fees'] as num?)?.toDouble(),
//     );
//   }
// }


class ProgramModel {
  final String? id;

  // ====== REQUIRED (core MVP) ======
  final String universityName;
  final String programName;
  final String studyField;
  final String country;
  final String degreeType;
  final bool moiAccepted;
  final String applyLink;
  final String? websiteLink;

  // ====== OPTIONAL (new scalable fields) ======
  final String? city;
  final String? language;
  final String? moiPolicy;
  final String? intake; // winter | summer | both
  final String? deadline;
  final String? duration;
  final double? tuitionFees;

  final double? ieltsRequirement;
  final double? toeflRequirement;
  final String? germanLevel;

  final bool? requiresAps;
  final bool? requiresBlockedAccount;
  final bool? isPublicUniversity;

  ProgramModel({
    this.id,

    // Required
    required this.universityName,
    required this.programName,
    required this.studyField,
    required this.country,
    required this.degreeType,
    required this.moiAccepted,
    required this.applyLink,
    required this.websiteLink,

    // Optional
    this.city,
    this.language,
    this.moiPolicy,
    this.intake,
    this.deadline,
    this.duration,
    this.tuitionFees,
    this.ieltsRequirement,
    this.toeflRequirement,
    this.germanLevel,
    this.requiresAps,
    this.requiresBlockedAccount,
    this.isPublicUniversity,
  });

  // factory ProgramModel.fromJson(Map<String, dynamic> json, {String? docId}) {
  //   return ProgramModel(
  //     id: docId ?? json['id']?.toString(),
  //
  //     // Required
  //     universityName: json['university_name'] ?? '',
  //     programName: json['program_name'] ?? '',
  //     studyField: json['study_field'] ?? '',
  //     country: json['country'] ?? '',
  //     degreeType: json['degree_type'] ?? '',
  //     moiAccepted: json['moi_accepted'] == true || json['moi_accepted'] == 'True',
  //     applyLink: json['application_link'] ?? '',
  //     websiteLink: json['website_link'],
  //
  //     // Optional
  //     city: json['city'],
  //     language: json['language'],
  //     moiPolicy: json['moi_policy'],
  //     intake: json['intake'],
  //     deadline: json['deadline_date'],
  //     duration: json['duration']?.toString(),
  //     tuitionFees: (json['tuition_fees'] as num?)?.toDouble(),
  //     ieltsRequirement: (json['ielts_requirement'] as num?)?.toDouble(),
  //     toeflRequirement: (json['toefl_requirement'] as num?)?.toDouble(),
  //     germanLevel: json['german_level'],
  //     requiresAps: json['requires_aps'],
  //     requiresBlockedAccount: json['requires_blocked_account'],
  //     isPublicUniversity: json['is_public_university'] == true || json['is_public_university'] == 'True',
  //   );
  // }
  factory ProgramModel.fromJson(Map<String, dynamic> json, {String? docId}) {

    // دالة مساعدة لتحويل أي قيمة (سواء كانت نص أو رقم) لـ Double بأمان
    double? parseDouble(dynamic value) {
      if (value == null) return null;
      if (value is num) return value.toDouble();
      if (value is String) {
        if (value.trim().isEmpty) return null; // لو النص فاضي
        return double.tryParse(value);
      }
      return null;
    }

    return ProgramModel(
      id: docId ?? json['id']?.toString(),

      // Required
      universityName: json['university_name']?.toString() ?? '',
      programName: json['program_name']?.toString() ?? '',
      studyField: json['study_field']?.toString() ?? '',
      country: json['country']?.toString() ?? '',
      degreeType: json['degree_type']?.toString() ?? '',

      moiAccepted: json['moi_accepted'] == true ||
          json['moi_accepted']?.toString().toLowerCase() == 'true',

      applyLink: json['application_link']?.toString() ?? '',
      websiteLink: json['website_link']?.toString(),

      // Optional
      city: json['city']?.toString(),
      language: json['language']?.toString(),
      moiPolicy: json['moi_policy']?.toString(),
      intake: json['intake']?.toString(),
      deadline: json['deadline_date']?.toString(),
      duration: json['duration']?.toString(),

      tuitionFees: parseDouble(json['tuition_fees']),
      ieltsRequirement: parseDouble(json['ielts_requirement']),
      toeflRequirement: parseDouble(json['toefl_requirement']),

      germanLevel: json['german_level']?.toString(),

      requiresAps: json['requires_aps'] == true ||
          json['requires_aps']?.toString().toLowerCase() == 'true',
      requiresBlockedAccount: json['requires_blocked_account'] == true ||
          json['requires_blocked_account']?.toString().toLowerCase() == 'true',
      isPublicUniversity: json['is_public_university'] == true ||
          json['is_public_university']?.toString().toLowerCase() == 'true',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'university_name': universityName,//✅
      'program_name': programName,//✅
      'study_field': studyField,
      'country': country,//✅
      'degree_type': degreeType,//✅
      'moi_accepted': moiAccepted,//✅
      'application_link': applyLink,//✅
      'website_link': websiteLink,//✅

      // Optional
      'city': city,//--about✅
      'language': language,//--adm-req-
      'moi_policy': moiPolicy,//--adm-req-
      'intake': intake,//--about✅
      'deadline_date': deadline,//--about✅
      'duration': duration,//✅
      'tuition_fees': tuitionFees,//✅
      'ielts_requirement': ieltsRequirement,//--adm-req-
      'toefl_requirement': toeflRequirement,//--adm-req-
      'german_level': germanLevel,//-if-german-adm-req-
      'requires_aps': requiresAps,//--fr-
      'requires_blocked_account': requiresBlockedAccount,//-if-german-adm-req-
      'is_public_university': isPublicUniversity,//--about✅
    };
  }

  factory ProgramModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProgramModel.fromJson(data, docId: doc.id);
  }
}

