class Article {
  final String category;
  final String title;
  final String summary;
  final String detail;
  final String image;

  final String basics;
  final String youtubeUrl;

  Article({
  required this.category,
  required this.title,
  required this.summary,
  required this.detail,
  required this.image,

  required this.basics,
  required this.youtubeUrl,
});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
  category: json['category'] ?? '',
  title: json['title'] ?? '',
  summary: json['summary'] ?? '',
  detail: json['detail'] ?? '',
  image: json['image'] ?? '',

  basics: json['basics'] ?? '',
  youtubeUrl: json['youtubeUrl'] ?? '',
);
  }
}