part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class InitialEvent extends SearchEvent {}

class SearchButtonClicked extends SearchEvent {}

class GifClicked extends SearchEvent {}
