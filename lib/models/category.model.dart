class Category {
  final int id;
  final String name;
  final int userId;
  final String fromEmail;

  Category(
      {required this.id,
      required this.name,
      required this.userId,
      required this.fromEmail});

  // JSON 데이터를 Filter 객체로 변환하는 팩토리 생성자
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'],
        name: json['name'],
        userId: json['user_id'],
        fromEmail: json['from_email']);
  }

// Filter 객체를 JSON 데이터로 변환하는 메서드 (필요한 경우)
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'userId': userId, 'fromEmail': fromEmail};
  }
}
