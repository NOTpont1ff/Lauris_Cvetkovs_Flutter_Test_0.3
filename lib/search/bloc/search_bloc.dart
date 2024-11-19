import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gif_with_bloc/API/giphy_api.dart';
import 'package:gif_with_bloc/model/gif_model.dart';
import 'package:meta/meta.dart';
import 'package:audioplayers/audioplayers.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchButtonClicked>(searchButtonClicked);
    on<GifClicked>(gifClicked);
    on<InitialEvent>(initialEvent);
  }

  // Handle InitialEvent
  Future<void> initialEvent(
      InitialEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
    try {
      final newItems = await GiphyApi.fetchGifs("cats", 1);
      emit(SearchLoadedSuccessState(gifs: newItems));
      print('Initial state uploaded');
    } catch (e) {
      print('Error fetching initial data: $e');
      emit(SearchErrorSuccessState());
    }
  }

  // Handle SearchButtonClicked Event
  Future<void> searchButtonClicked(
      SearchButtonClicked event, Emitter<SearchState> emit) async {
    final _audioPlayer = AudioPlayer();
    try {
      // Play sound
      await _audioPlayer.play(AssetSource('FX/4Elements2OSTGoodMelodySFX.mp3'));
      print('Audio play completed');

      // Show loading while fetching data
      emit(SearchLoadingState());

      // Fetch GIFs based on the search query
      final newItems = await GiphyApi.fetchGifs(event.text, 1); // Use event.text here
      emit(SearchLoadedSuccessState(gifs: newItems));
      print('GIFs fetched successfully for query: ${event.text}');
    } catch (e) {
      print('Error during search: $e');
      emit(SearchErrorSuccessState());
    }
  }

  // Handle GifClicked Event
  FutureOr<void> gifClicked(GifClicked event, Emitter<SearchState> emit) {
    print('GIF button clicked');
    emit(SearchNavigateToDetailPage());
  }
}
