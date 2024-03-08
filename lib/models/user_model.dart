class UserModel {
  final String userEmail;
  final String userName;

  UserModel({
    required this.userEmail,
    required this.userName,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      userEmail: data['email'],
      userName: data['userName'],
    );
  }
}
