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
  Future<void> initialEvent(
      InitialEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
    await Future.delayed(Duration(seconds: 3));
    final newItems = await GiphyApi.fetchGifs("cats", 1);
    print('Initial state uploaded');
    emit(SearchLoadedSuccessState(gifs: newItems));
  }

  Future<void> searchButtonClicked(
      SearchButtonClicked event, Emitter<SearchState> emit) async {
    print("audio play");
    final _audioPlayer = AudioPlayer();
    try {
      await _audioPlayer.play(
          AssetSource('FX/4Elements2OSTGoodMelodySFX.mp3'));
      print('Audio play completed');
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  FutureOr<void> gifClicked(GifClicked event, Emitter<SearchState> emit) {
    print('gif button clicked');
    emit(SearchNavigateToDetailPage());
  }
}
