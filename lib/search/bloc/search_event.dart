part of 'search_bloc.dart';

abstract class SearchEvent {}

class InitialEvent extends SearchEvent {}

class SearchButtonClicked extends SearchEvent {
  final String text;
  SearchButtonClicked({required this.text});
}

class GifClicked extends SearchEvent {
  final GifModel gif;
  GifClicked({required this.gif});
}

class LoadMoreGifs extends SearchEvent {
  final String text;
  LoadMoreGifs({required this.text});
}
