class DeviceModel {
  String id;
  String deviceType;
  String deviceName;
  String deviceCategory;
  String userUID;
  DateTime? timestamp;
  String? currentDate;
  String? currentTime;
  String deviceModel;
  String deviceManufacturingYear;
  String devicePrice;
  String deviceDetails;
  String deviceImage;
  String isDeviceApprove;
  double rating;

  DeviceModel({
    required this.id,
    required this.rating,
    required this.deviceType,
    required this.deviceName,
    required this.deviceCategory,
    required this.userUID,
    DateTime? timestamp,
    String? currentDate,
    String? currentTime,
    String? isDeviceApprove,
    required this.deviceModel,
    required this.deviceManufacturingYear,
    required this.devicePrice,
    required this.deviceDetails,
    required this.deviceImage,
  })  : timestamp = timestamp ?? DateTime.now(),
        currentDate = currentDate ??
            '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
        currentTime = currentTime ??
            '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
        isDeviceApprove = "false" //
  ;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'deviceType': deviceType,
      'deviceName': deviceName,
      'deviceCategory': deviceCategory,
      'userUID': userUID,
      'timestamp': timestamp?.toIso8601String(), // Use safe null-aware access
      'currentDate': currentDate,
      'currentTime': currentTime,
      'deviceModel': deviceModel,
      'deviceManufacturingYear': deviceManufacturingYear,
      'devicePrice': devicePrice,
      'deviceDetails': deviceDetails,
      'deviceImage': deviceImage,
      'deviceApprove': isDeviceApprove,
      'rating': rating
    };
  }

  factory DeviceModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return DeviceModel(
        id: '',
        deviceType: '',
        deviceName: '',
        deviceCategory: '',
        userUID: '',
        rating: 0.0,
        timestamp: DateTime.now(),
        currentDate:
            '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
        currentTime:
            '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
        deviceModel: '',
        deviceManufacturingYear: '',
        devicePrice: '',
        deviceDetails: '',
        deviceImage: '',
        isDeviceApprove: "false",
      );
    }
    return DeviceModel(
      id: map['id'] ?? '',
      rating: map['rating'] ?? '',
      deviceType: map['deviceType'] ?? '',
      deviceName: map['deviceName'] ?? '',
      deviceCategory: map['deviceCategory'] ?? '',
      userUID: map['userUID'] ?? '',
      timestamp:
          map['timestamp'] != null ? DateTime.parse(map['timestamp']) : null,
      currentDate: map['currentDate'] ??
          '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
      currentTime: map['currentTime'] ??
          '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
      deviceModel: map['deviceModel'] ?? '',
      deviceManufacturingYear: map['deviceManufacturingYear'] ?? '',
      devicePrice: map['devicePrice'] ?? '',
      deviceDetails: map['deviceDetails'] ?? '',
      deviceImage: map['deviceImage'] ?? '',
      isDeviceApprove: map['deviceApprove'] ?? "false",
    );
  }
}
