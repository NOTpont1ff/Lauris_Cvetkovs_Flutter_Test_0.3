import 'package:equatable/equatable.dart';

class GifModel extends Equatable {
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

  // Factory method to create a GifModel instance from JSON
  factory GifModel.fromJson(Map<String, dynamic> json) {
    return GifModel(
      id: json['id'],
      title: json['title'],
      url: json['images']['fixed_height']['url'],
      user: json['username'] != null && json['username'].isNotEmpty
          ? json['username']
          : "Unknown",
    );
  }

  // Equatable props for value-based comparison
  @override
  List<Object?> get props => [id, title, url, user];
}
