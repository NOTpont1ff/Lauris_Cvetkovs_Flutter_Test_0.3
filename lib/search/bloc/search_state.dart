part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

abstract class SearchActionState extends SearchState {}

final class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedSuccessState extends SearchState {
  final List<GifModel> gifs;
  final bool hasReachedMax;
  SearchLoadedSuccessState({required this.gifs, this.hasReachedMax = false});
}

class SearchDetailState extends SearchState {
  final GifModel gif;
  SearchDetailState({required this.gif});
}

class SearchErrorState extends SearchState {
  final String message;
  SearchErrorState({this.message = 'Something went wrong.\nTry again later'});
}

class NoGifsFoundState extends SearchState {}
