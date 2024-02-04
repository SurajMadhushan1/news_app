class NewsModel {
  String? title;
  String? date;
  String? image;
  String? author;
  String? url;

  NewsModel({this.title, this.date, this.image, this.author, this.url});

  factory NewsModel.fromjson(Map<String, dynamic> map) {
    return NewsModel(
      title: map['title'] ?? "Breaking News",
      date: map['publishedAt'] ?? "Today",
      image: map['urlToImage'] ??
          "https://image.freepik.com/free-vector/breaking-news-banner-with-world-map_275806-283.jpg",
      author: map['author'],
      url: map['url'],
    );
  }
}
