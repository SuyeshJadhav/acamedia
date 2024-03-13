class User {
  final String userId;
  final String title;
  final String author;

  User({required this.userId, required this.title, required this.author});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      title: json['title'],
      author: json['author'],
    );
  }
}
