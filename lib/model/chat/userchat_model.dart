class UserchatModel {
  final String id;
  final String ownerName;
  final String email;
  final String profilePicture;
  final String userId;

  UserchatModel({
    required this.id,
    required this.ownerName,
    required this.email,
    required this.profilePicture,
    required this.userId,
  });

  factory UserchatModel.fromMap(Map<String, dynamic> map) {
    return UserchatModel(
      id: map['userId'] ?? "",
      ownerName: map['ownerName'] ?? "",
      email: map['email'] ?? "",
      profilePicture: map['profilePicture'] ?? "",
      userId: map['userId'] ?? "",
    );
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $ownerName, email: $email, image: $profilePicture}';
  }
}