part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

abstract class SearchActionState extends SearchState {}

final class SearchInitial extends SearchState {
  
}

class SearchLoadingState extends SearchState {}

class SearchLoadedSuccessState extends SearchState {
  final List<GifModel> gifs;

  SearchLoadedSuccessState({required this.gifs});
  
}

class SearchErrorSuccessState extends SearchState {}

class SearchNavigateToDetailPage extends SearchActionState {}
