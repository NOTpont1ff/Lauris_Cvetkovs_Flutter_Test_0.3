
part of 'search_bloc.dart';

@immutable
sealed class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

abstract class SearchActionState extends SearchState {}

final class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {}

// ignore: must_be_immutable
class SearchLoadedSuccessState extends SearchState {
  final List<GifModel> gifs;
  final bool hasReachedMax;
  var gifCount;
  SearchLoadedSuccessState({required this.gifs, this.hasReachedMax = false, this.gifCount});

  @override
  List<Object?> get props => [gifs, hasReachedMax]; 
}

class SearchDetailState extends SearchState {
  final GifModel gif;

  SearchDetailState({required this.gif});

  @override
  List<Object?> get props => [gif];  
}

class SearchErrorState extends SearchState {
  final String message;

  SearchErrorState({this.message = 'Something went wrong.\nTry again later'});

  @override
  List<Object?> get props => [message]; 
}

class NoGifsFoundState extends SearchState {}

