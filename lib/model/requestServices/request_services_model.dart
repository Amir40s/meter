import 'package:cloud_firestore/cloud_firestore.dart';
import 'send_request_model.dart';

class RequestServicesModel {
  String id;
  String activityType;
  String role;
  String pricingPurpose;
  String surveyReport;
  String userUID;
  String long;
  DateTime timestamp;
  String currentDate;
  String lat;
  String userName;
  String currentTime;
  String reportNumber;
  String instrumentNumber;
  String certificateType;
  String region;
  String city;
  String neighborhood;
  String location;
  String pieceNumber;
  String chartNumber;
  String applicationType;
  String agencyNumber;
  String applicationName;
  String phoneNumber;
  String idNumber;
  String documentImage;
  String consolationType;
  String consolationTitle;
  String details;
  String specializations;
  String haveExperience;
  String experience;
  String preferredCityWork;
  String email;
  String name;
  String userProfileImage;
  int proposalCount;
  List<SendRequestModel> proposals;

  RequestServicesModel({
    required this.id,
    required this.role,
    this.activityType = '',
    this.agencyNumber = "",
    this.long = "",
    this.lat = "",
    this.userName = "",
    this.experience = "",
    this.proposalCount = 0,
    this.pricingPurpose = '',
    this.surveyReport = '',
    required this.userUID,
    this.reportNumber = '',
    this.instrumentNumber = '',
    this.certificateType = '',
    this.region = '',
    this.city = '',
    this.neighborhood = '',
    this.location = '',
    this.pieceNumber = '',
    this.chartNumber = '',
    this.applicationType = '',
    this.applicationName = '',
    this.phoneNumber = '',
    this.idNumber = '',
    this.documentImage = '',
    this.consolationType = '',
    this.consolationTitle = '',
    this.details = '',
    this.specializations = '',
    this.haveExperience = '',
    this.preferredCityWork = '',
    this.email = '',
    this.name = '',
    this.userProfileImage = '',
    DateTime? timestamp,
    String? currentDate,
    String? currentTime,
    this.proposals = const [],
  })  : this.timestamp = timestamp ?? DateTime.now(),
        this.currentDate = currentDate ??
            '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
        this.currentTime = currentTime ??
            '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';

  RequestServicesModel copyWith({int? proposalCount, List<SendRequestModel>? proposals}) {
    return RequestServicesModel(
      id: this.id,
      role: this.role,
      activityType: this.activityType,
      agencyNumber: this.agencyNumber,
      long: this.long,
      lat: this.lat,
      userName: this.userName,
      experience: this.experience,
      proposalCount: proposalCount ?? this.proposalCount,
      pricingPurpose: this.pricingPurpose,
      surveyReport: this.surveyReport,
      userUID: this.userUID,
      reportNumber: this.reportNumber,
      instrumentNumber: this.instrumentNumber,
      certificateType: this.certificateType,
      region: this.region,
      city: this.city,
      neighborhood: this.neighborhood,
      location: this.location,
      pieceNumber: this.pieceNumber,
      chartNumber: this.chartNumber,
      applicationType: this.applicationType,
      applicationName: this.applicationName,
      phoneNumber: this.phoneNumber,
      idNumber: this.idNumber,
      documentImage: this.documentImage,
      consolationType: this.consolationType,
      consolationTitle: this.consolationTitle,
      details: this.details,
      specializations: this.specializations,
      haveExperience: this.haveExperience,
      preferredCityWork: this.preferredCityWork,
      email: this.email,
      name: this.name,
      userProfileImage: this.userProfileImage,
      timestamp: this.timestamp,
      currentDate: this.currentDate,
      currentTime: this.currentTime,
      proposals: proposals ?? this.proposals,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role': role,
      'userProfileImage': userProfileImage,
      'long': long,
      'lat': lat,
      'userName': userName,
      'proposalCount': proposalCount,
      'activityType': activityType,
      'pricingPurpose': pricingPurpose,
      'surveyReport': surveyReport,
      'userUID': userUID,
      'reportNumber': reportNumber,
      'instrumentNumber': instrumentNumber,
      'certificateType': certificateType,
      'region': region,
      'city': city,
      'neighborhood': neighborhood,
      'location': location,
      'pieceNumber': pieceNumber,
      'chartNumber': chartNumber,
      'applicationType': applicationType,
      'applicationName': applicationName,
      'phoneNumber': phoneNumber,
      'idNumber': idNumber,
      'documentImage': documentImage,
      'consolationType': consolationType,
      'consolationTitle': consolationTitle,
      'details': details,
      'agencyNumber': agencyNumber,
      'specializations': specializations,
      'haveExperience': haveExperience,
      'preferredCityWork': preferredCityWork,
      'email': email,
      'name': name,
      'timestamp': timestamp.toIso8601String(),
      'currentDate': currentDate,
      'currentTime': currentTime,
      'proposals': proposals.map((p) => p.toMap()).toList(),
    };
  }

  factory RequestServicesModel.fromMap(Map<String, dynamic> map) {
    return RequestServicesModel(
      id: map['id'] ?? '',
      role: map['role'] ?? '',
      activityType: map['activityType'] ?? '',
      pricingPurpose: map['pricingPurpose'] ?? '',
      long: map['long'] ?? '',
      lat: map['lat'] ?? '',
      userName: map['userName'] ?? '',
      surveyReport: map['surveyReport'] ?? '',
      userUID: map['userUID'] ?? '',
      reportNumber: map['reportNumber'] ?? '',
      instrumentNumber: map['instrumentNumber'] ?? '',
      certificateType: map['certificateType'] ?? '',
      region: map['region'] ?? '',
      city: map['city'] ?? '',
      neighborhood: map['neighborhood'] ?? '',
      location: map['location'] ?? '',
      pieceNumber: map['pieceNumber'] ?? '',
      chartNumber: map['chartNumber'] ?? '',
      applicationType: map['applicationType'] ?? '',
      applicationName: map['applicationName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      idNumber: map['idNumber'] ?? '',
      documentImage: map['documentImage'] ?? '',
      consolationType: map['consolationType'] ?? '',
      consolationTitle: map['consolationTitle'] ?? '',
      details: map['details'] ?? '',
      agencyNumber: map['agencyNumber'] ?? '',
      specializations: map['specializations'] ?? '',
      haveExperience: map['haveExperience'] ?? '',
      preferredCityWork: map['preferredCityWork'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      userProfileImage: map['userProfileImage'] ?? '',
      proposalCount: map['proposalCount'] ?? 0,
      timestamp: map['timestamp'] != null
          ? DateTime.parse(map['timestamp'])
          : DateTime.now(),
      currentDate: map['currentDate'] ??
          '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
      currentTime: map['currentTime'] ??
          '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
      proposals: map['proposals'] != null
          ? List<SendRequestModel>.from(
          map['proposals'].map((p) => SendRequestModel.fromMap(p)))
          : [],
    );
  }

  factory RequestServicesModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return RequestServicesModel(
      id: doc.id,
      role: data['role'] ?? '',
      activityType: data['activityType'] ?? '',
      pricingPurpose: data['pricingPurpose'] ?? '',
      userName: data['userName'] ?? '',
      lat: data['lat'] ?? '',
      surveyReport: data['surveyReport'] ?? '',
      long: data['long'] ?? '',
      userUID: data['userUID'] ?? '',
      reportNumber: data['reportNumber'] ?? '',
      instrumentNumber: data['instrumentNumber'] ?? '',
      certificateType: data['certificateType'] ?? '',
      region: data['region'] ?? '',
      city: data['city'] ?? '',
      neighborhood: data['neighborhood'] ?? '',
      location: data['location'] ?? '',
      pieceNumber: data['pieceNumber'] ?? '',
      chartNumber: data['chartNumber'] ?? '',
      applicationType: data['applicationType'] ?? '',
      applicationName: data['applicationName'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      idNumber: data['idNumber'] ?? '',
      documentImage: data['documentImage'] ?? '',
      consolationType: data['consolationType'] ?? '',
      consolationTitle: data['consolationTitle'] ?? '',
      details: data['details'] ?? '',
      agencyNumber: data['agencyNumber'] ?? '',
      specializations: data['specializations'] ?? '',
      haveExperience: data['haveExperience'] ?? '',
      preferredCityWork: data['preferredCityWork'] ?? '',
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      userProfileImage: data['userProfileImage'] ?? '',
      proposalCount: 0, // This will be updated later
      timestamp: data['timestamp'] != null
          ? DateTime.parse(data['timestamp'])
          : DateTime.now(),
      currentDate: data['currentDate'] ??
          '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
      currentTime: data['currentTime'] ??
          '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
      proposals: [], // This will be updated later
    );
  }
}
