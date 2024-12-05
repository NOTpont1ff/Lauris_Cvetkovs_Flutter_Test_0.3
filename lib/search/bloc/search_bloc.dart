import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:gif_with_bloc/API/giphy_api.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:gif_with_bloc/model/gif_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GiphyApi giphyApi;
  final Connectivity connectivity;
  int _page = 1;
  final int _limit = 20;
  String _currentQuery = '';

  SearchBloc({required this.giphyApi, required this.connectivity}) : super(SearchInitial()) {
    on<SearchButtonClicked>(_onSearchButtonClicked,
        transformer: debounce(Duration(milliseconds: 300)));
    on<LoadMoreGifs>(onLoadMoreGifs);
    on<GifClicked>(_onGifClicked);
    on<InitialEvent>(_onInitialEvent);
  

  // Rest of the code remains the same
}

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  Future<void> _onSearchButtonClicked(
      SearchButtonClicked event, Emitter<SearchState> emit) async {
    _page = 1;
    _currentQuery = event.text.trim();
    if (_currentQuery.isEmpty) {
      emit(SearchInitial());
      return;
    }
    var connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      emit(SearchErrorState(message: 'No internet connection.'));
      return;
    }

    try {
      final gifs = await giphyApi.fetchGifs(_currentQuery, _page);
      if (gifs.isNotEmpty) {
        emit(SearchLoadedSuccessState(
            gifs: gifs, hasReachedMax: gifs.length < _limit));
      } else {
        emit(NoGifsFoundState());
      }
    } catch (e) {
      emit(SearchErrorState(message: 'Error fetching GIFs. Please try again later.'));
    }
  }

  Future<void> onLoadMoreGifs(
      LoadMoreGifs event, Emitter<SearchState> emit) async {
    var connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      emit(SearchErrorState(message: 'No internet connection'));
      return;
    }
    final currentState = state;
    if (currentState is SearchLoadedSuccessState &&
        !currentState.hasReachedMax) {
      try {
        _page++;
        final newGifs = await giphyApi.fetchGifs(_currentQuery, _page);
        final allGifs = List<GifModel>.from(currentState.gifs)..addAll(newGifs);

        emit(SearchLoadedSuccessState(
          gifs: allGifs,
          hasReachedMax: newGifs.length < _limit,
        ));
      } catch (e) {
        emit(SearchErrorState(message: 'Error loading more GIFs.'));
      }
    }
  }

  void _onGifClicked(GifClicked event, Emitter<SearchState> emit) {
    emit(SearchDetailState(gif: event.gif));
  }

  Future<void> _onInitialEvent(
      InitialEvent event, Emitter<SearchState> emit) async {
    emit(SearchInitial());
  }
}
