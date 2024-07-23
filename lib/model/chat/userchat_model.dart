class UserchatModel {
  final String id;
  final String ownerName;
  final String email;
  final String profilePicture;
  final String userUID;

  UserchatModel({
    required this.id,
    required this.ownerName,
    required this.email,
    required this.profilePicture,
    required this.userUID,
  });

  factory UserchatModel.fromMap(Map<String, dynamic> map) {
    return UserchatModel(
      id: map['userId'] ?? "",
      ownerName: map['ownerName'] ?? "",
      email: map['email'] ?? "",
      profilePicture: map['profilePicture'] ?? "",
      userUID: map['userUID'] ?? "",
    );
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $ownerName, email: $email, image: $profilePicture}';
  }
}