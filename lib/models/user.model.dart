class User {
  final int id;
  final String email;
  final String googleId;

  User({required this.id, required this.email, required this.googleId});

  // JSON 데이터를 Filter 객체로 변환하는 팩토리 생성자
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'], email: json['email'], googleId: json['google_id']);
  }

// Filter 객체를 JSON 데이터로 변환하는 메서드 (필요한 경우)
  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'googleId': googleId};
  }
}
