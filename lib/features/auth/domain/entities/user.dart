import 'package:equatable/equatable.dart';

class Meme extends Equatable {
  const Meme({
    required this.title,
    required this.author,
    required this.url,
    required this.nsfw,
    required this.spoiler,
  });

  final String title;
  final String author;
  final String url;
  final bool nsfw;
  final bool spoiler;

  @override
  List<Object?> get props => [url];
}