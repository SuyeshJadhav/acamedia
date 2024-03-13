class UserLogin {
  final String userId;
  final String message;
  final String status;

  UserLogin(
      {required this.userId, required this.message, required this.status});

  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
      userId: json['userId'],
      message: json['message'],
      status: json['status'],
    );
  }
}
