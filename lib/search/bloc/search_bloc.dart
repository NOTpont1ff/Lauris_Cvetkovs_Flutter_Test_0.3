import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:gif_with_bloc/API/giphy_api.dart';
import 'package:gif_with_bloc/model/gif_model.dart';
import 'package:audioplayers/audioplayers.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchButtonClicked>(
      searchButtonClicked,
      transformer: debounce(const Duration(milliseconds: 300)),
    );

    on<GifClicked>(gifClicked);
    on<InitialEvent>(initialEvent);
  }

  
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) {
      return events.debounceTime(duration).flatMap(mapper);
    };
  }

  Future<void> initialEvent(InitialEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
    await Future.delayed(Duration(milliseconds: 500)); 
    emit(SearchInitial());
  }

  Future<void> searchButtonClicked(SearchButtonClicked event, Emitter<SearchState> emit) async {
    final _audioPlayer = AudioPlayer();
    if (event.text.isEmpty) {
      emit(SearchInitial());
      return;
    }
    try {
      await _audioPlayer.play(AssetSource('FX/4Elements2OSTGoodMelodySFX.mp3'));
      emit(SearchLoadingState());
      final newItems = await GiphyApi.fetchGifs(event.text, 1);
      emit(SearchLoadedSuccessState(gifs: newItems));
    } catch (e) {
      print('Error during search: $e');
      emit(SearchErrorSuccessState());
    }
  }

  void gifClicked(GifClicked event, Emitter<SearchState> emit) {
    emit(SearchDetailState(gif: event.gif));
  }
}
