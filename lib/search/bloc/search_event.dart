part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class InitialEvent extends SearchEvent {}

class SearchButtonClicked extends SearchEvent {
  final String text;
  
  SearchButtonClicked({required this.text});
  
}

class GifClicked extends SearchEvent {}
