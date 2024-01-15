class Quote {
  late String quote;
  late String author;
  late String category;
  Quote({
    required this.quote,
    required this.author,
    required this.category,
  });

  Quote.fromJson(Map<String, dynamic> json) {
    quote = json['quote'];
    author = json['author'];
    category = json['category'];
  }
}
