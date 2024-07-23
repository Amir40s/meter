class RequestServicesModel {
  String id;
  String activityType;
  String role;
  String pricingPurpose;
  String surveyReport;
  String userUID;
  DateTime timestamp;
  String currentDate;
  String currentTime;
  String reportNumber;
  String instrumentNumber;
  String certificateType;
  String region;
  String city;
  String neighborhood;
  String location;
  String long;
  String lat;
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
  String userName;
  String requestStatus;
  RequestServicesModel({
    required this.id,
    required this.role,
    this.activityType = '',
    this.requestStatus = "New",
    this.agencyNumber = "",
    this.experience = "",
    this.userName = '',
    this.pricingPurpose = '',
    this.surveyReport = '',
    this.long = '',
    this.lat = '',
    required this.userUID,
    this.reportNumber = '',
    this.userProfileImage = '',
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
    DateTime? timestamp,
    String? currentDate,
    String? currentTime,
  })  : this.timestamp = timestamp ?? DateTime.now(),
        this.currentDate = currentDate ??
            '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
        this.currentTime = currentTime ??
            '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role': role,
      'requestStatus': requestStatus,
      'userName': userName,
      'activityType': activityType,
      'pricingPurpose': pricingPurpose,
      'surveyReport': surveyReport,
      'userUID': userUID,
      'long': long,
      'lat': lat,
      'userProfileImage': userProfileImage,
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
      "agencyNumber": agencyNumber,
      'specializations': specializations,
      'haveExperience': haveExperience,
      'preferredCityWork': preferredCityWork,
      'email': email,
      'name': name,
      'timestamp': timestamp.toIso8601String(),
      'currentDate': currentDate,
      'currentTime': currentTime,
    };
  }

  factory RequestServicesModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return RequestServicesModel(
        id: '',
        role: '',
        long: '0.0',
        lat: '0.0',
        activityType: '',
        experience: '',
        pricingPurpose: '',
        surveyReport: '',
        userUID: '',
        requestStatus: '',
        reportNumber: '',
        instrumentNumber: '',
        certificateType: '',
        region: '',
        city: '',
        userProfileImage: '',
        neighborhood: '',
        location: '',
        pieceNumber: '',
        chartNumber: '',
        applicationType: '',
        applicationName: '',
        phoneNumber: '',
        idNumber: '',
        userName: '',
        documentImage: '',
        consolationType: '',
        consolationTitle: '',
        details: '',
        agencyNumber: "",
        specializations: '',
        haveExperience: '',
        preferredCityWork: '',
        email: '',
        name: '',
      );
    }
    return RequestServicesModel(
      id: map['id'] ?? '',
      requestStatus: map['requestStatus'] ?? '',
      role: map['requestServiceType'] ?? '',
      experience: map['experience'] ?? '',
      activityType: map['activityType'] ?? '',
      pricingPurpose: map['pricingPurpose'] ?? '',
      surveyReport: map['surveyReport'] ?? '',
      userUID: map['userUID'] ?? '',
      reportNumber: map['reportNumber'] ?? '',
      instrumentNumber: map['instrumentNumber'] ?? '',
      certificateType: map['certificateType'] ?? '',
      region: map['region'] ?? '',
      city: map['city'] ?? '',
      long: map['long'] ?? '0.0',
      lat: map['lat'] ?? '0.0',
      userProfileImage: map['userProfileImage'] ?? '',
      neighborhood: map['neighborhood'] ?? '',
      location: map['location'] ?? '',
      agencyNumber: map["agencyNumber"] ?? '',
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
      specializations: map['specializations'] ?? '',
      haveExperience: map['haveExperience'] ?? '',
      preferredCityWork: map['preferredCityWork'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      timestamp: map['timestamp'] != null
          ? DateTime.parse(map['timestamp'])
          : DateTime.now(),
      currentDate: map['currentDate'] ??
          '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
      currentTime: map['currentTime'] ??
          '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
    );
  }
}
