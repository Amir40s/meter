class UserModel {
  String userId;
  String role;
  String serviceProvider;
  String facilityName;
  String facilityNumber;
  String commercialRegistration;
  String facilityActivity;
  String ownerName;
  String phoneNumber;
  String managerName;
  String managerPhoneNumber;
  String descriptionOfServices;
  String profilePicture;
  bool isFaceVerify;
  bool isFingerVerify;
  String region;
  String city;
  String neighborhood;
  String location;
  String long;
  String lat;
  String password;
  DateTime timestamp;
  String fileUrl;
  String email;
  String typeOfActivity;
  String licenseNumber;
  String commercialRegistrationDate;
  String iosCommercialRegistrationDate;

  UserModel({
    required this.userId,
    required this.role,
    this.serviceProvider = "",
    this.facilityName = "",
    this.facilityNumber = "",
    this.commercialRegistration = "",
    this.facilityActivity = "",
    this.ownerName = "",
    this.phoneNumber = "",
    this.managerName = "",
    this.managerPhoneNumber = "",
    this.descriptionOfServices = "",
    this.profilePicture = "",
    this.isFaceVerify = false,
    this.isFingerVerify = false,
    this.region = "",
    this.city = "",
    this.neighborhood = "",
    this.location = "",
    this.long = "",
    this.lat = "",
    this.password = "",
    this.fileUrl = "",
    this.email = "",
    this.typeOfActivity = "",
    this.licenseNumber = "",
    this.commercialRegistrationDate = "",
    this.iosCommercialRegistrationDate = "",
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] ?? '',
      role: json['role'] ?? '',
      serviceProvider: json['serviceProvider'] ?? '',
      facilityName: json['facilityName'] ?? '',
      facilityNumber: json['facilityNumber'] ?? '',
      commercialRegistration: json['commercialRegistration'] ?? '',
      facilityActivity: json['facilityActivity'] ?? '',
      ownerName: json['ownerName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      managerName: json['managerName'] ?? '',
      managerPhoneNumber: json['managerPhoneNumber'] ?? '',
      descriptionOfServices: json['descriptionOfServices'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      isFaceVerify: json['isFaceVerify'] ?? false,
      isFingerVerify: json['isFingerVerify'] ?? false,
      region: json['region'] ?? '',
      city: json['city'] ?? '',
      neighborhood: json['neighborhood'] ?? '',
      location: json['location'] ?? '',
      long: json['long'] ?? '',
      lat: json['lat'] ?? '',
      password: json['password'] ?? '',
      fileUrl: json['fileUrl'] ?? '',
      email: json['email'] ?? '',
      typeOfActivity: json['typeOfActivity'] ?? '',
      licenseNumber: json['licenseNumber'] ?? '',
      commercialRegistrationDate: json['commercialRegistrationDate'] ?? '',
      iosCommercialRegistrationDate:
      json['iosCommercialRegistrationDate'] ?? '',
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'role': role,
      'serviceProvider': serviceProvider,
      'facilityName': facilityName,
      'facilityNumber': facilityNumber,
      'commercialRegistration': commercialRegistration,
      'facilityActivity': facilityActivity,
      'ownerName': ownerName,
      'phoneNumber': phoneNumber,
      'managerName': managerName,
      'managerPhoneNumber': managerPhoneNumber,
      'descriptionOfServices': descriptionOfServices,
      'profilePicture': profilePicture,
      'isFaceVerify': isFaceVerify,
      'isFingerVerify': isFingerVerify,
      'region': region,
      'city': city,
      'neighborhood': neighborhood,
      'location': location,
      'long': long,
      'lat': lat,
      'password': password,
      'fileUrl': fileUrl,
      'email': email,
      'typeOfActivity': typeOfActivity,
      'licenseNumber': licenseNumber,
      'commercialRegistrationDate': commercialRegistrationDate,
      'iosCommercialRegistrationDate': iosCommercialRegistrationDate,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
