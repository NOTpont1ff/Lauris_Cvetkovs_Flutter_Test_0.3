import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gif_with_bloc/API/giphy_api.dart';
import 'package:gif_with_bloc/model/gif_model.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchButtonClicked>(searchButtonClicked);
    on<GifClicked>(gifClicked);
    on<InitialEvent>(initialEvent);
  }
  Future<void> initialEvent(InitialEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
    await Future.delayed(Duration(seconds: 3));
    final newItems =
          await GiphyApi.fetchGifs("cats", 1);
    print('Initial state uploaded');
    emit(SearchLoadedSuccessState(gifs: newItems));
    
  }

  FutureOr<void> searchButtonClicked(
      SearchButtonClicked event, Emitter<SearchState> emit) {
    print('Search button clicked');
  }

  FutureOr<void> gifClicked(GifClicked event, Emitter<SearchState> emit) {
    print('gif button clicked');
    emit(SearchNavigateToDetailPage());
  }
}
