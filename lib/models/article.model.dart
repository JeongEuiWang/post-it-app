class Article {
  final String title;
  final String snippet;
  final String date;
  final String messageId;

  Article({
    required this.title,
    required this.snippet,
    required this.date,
    required this.messageId
  });

  // JSON 데이터를 Filter 객체로 변환하는 팩토리 생성자
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        title: json['title'], snippet: json['snippet'], date: json['date'], messageId: json['message_id']);
  }
}
