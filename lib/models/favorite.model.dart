class Favorite {
  final int id;
  final int userId;
  final int categoryId;
  final String messageId;

  Favorite(
      {required this.id,
      required this.userId,
      required this.categoryId,
      required this.messageId});

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
        id: json['id'],
        userId: json['user_id'],
        categoryId: json['category_id'],
        messageId: json['message_id']);
  }
}
