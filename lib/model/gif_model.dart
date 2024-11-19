class GifModel {
  final String id;
  final String title;
  final String url;
  final String user;

  GifModel({
    required this.id,
    required this.title,
    required this.url,
    required this.user,
  });

  factory GifModel.fromJson(Map<String, dynamic> json) {
    return GifModel(
      id: json['id'],
      title: json['title'],
      url: json['images']['fixed_height']['url'],
      user: json['username'] ?? 'Unknown',
    );
  }
}