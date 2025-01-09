class ArticleDetail {
  final String categoryName;
  final String title;
  final String snippet;
  final String date;
  final String content;

  ArticleDetail(
      {required this.categoryName,
      required this.title,
      required this.snippet,
      required this.date,
      required this.content});

  // JSON 데이터를 Filter 객체로 변환하는 팩토리 생성자
  factory ArticleDetail.fromJson(Map<String, dynamic> json) {
    return ArticleDetail(
        categoryName: json['category_name'],
        title: json['title'],
        snippet: json['snippet'],
        date: json['date'],
        content: json['content']);
  }
}
