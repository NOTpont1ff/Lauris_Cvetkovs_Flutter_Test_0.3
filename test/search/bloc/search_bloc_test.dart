import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:gif_with_bloc/search/bloc/search_bloc.dart';
import 'package:gif_with_bloc/API/giphy_api.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:gif_with_bloc/model/gif_model.dart';

class MockGiphyApi extends Mock implements GiphyApi {}

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  List<GifModel> generateGifs(int count) {
    return List.generate(count, (index) {
      return GifModel(
        id: (index + 1).toString(),
        title: 'Gif ${index + 1}',
        url: 'url${index + 1}',
        user: '',
      );
    });
  }

  late SearchBloc searchBloc;
  late MockGiphyApi mockGiphyApi;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockGiphyApi = MockGiphyApi();
    mockConnectivity = MockConnectivity();
    searchBloc = SearchBloc(giphyApi: mockGiphyApi, connectivity: mockConnectivity);

    registerFallbackValue(SearchButtonClicked(text: ''));
    registerFallbackValue(
        GifClicked(gif: GifModel(id: '', title: '', url: '', user: '')));
    registerFallbackValue(InitialEvent());
    registerFallbackValue(LoadMoreGifs(text: ''));
    reset(mockConnectivity);
  });

  tearDown(() {
    searchBloc.close();
  });

  group('SearchBloc Tests', () {
    test('initial state is SearchInitial', () {
      expect(searchBloc.state, SearchInitial());
    });

    blocTest<SearchBloc, SearchState>(
      'emits SearchLoadingState and SearchLoadedSuccessState when search is successful',
      build: () {
        when(() => mockConnectivity.checkConnectivity())
            .thenAnswer((_) async => [ConnectivityResult.wifi]);

        when(() => mockGiphyApi.fetchGifs(any(), any())).thenAnswer((_) async =>
            [
              GifModel(id: '1', title: 'Funny Gif', url: 'url', user: 'user')
            ]);

        return searchBloc;
      },
      act: (bloc) => bloc.add(SearchButtonClicked(text: 'funny')),
      wait: Duration(seconds: 2),
      expect: () => [
        SearchLoadingState(),
        SearchLoadedSuccessState(
          gifs: [
            GifModel(id: '1', title: 'Funny Gif', url: 'url', user: 'user')
          ],
          hasReachedMax: true,
          gifCount: 1,
        ),
      ],
    );
    blocTest<SearchBloc, SearchState>(
      'emits NoGifsFoundState when no gifs are returned from the API',
      build: () {
        when(() => mockConnectivity.checkConnectivity())
            .thenAnswer((_) async => [ConnectivityResult.wifi]);
        when(() => mockGiphyApi.fetchGifs(any(), any()))
            .thenAnswer((_) async => []);
        return searchBloc;
      },
      act: (bloc) => bloc.add(SearchButtonClicked(text: 'funny')),
      wait: Duration(seconds: 2),
      expect: () => [
        SearchLoadingState(),
        NoGifsFoundState(),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'emits SearchErrorState when there is an error fetching gifs',
      build: () {
        when(() => mockConnectivity.checkConnectivity())
            .thenAnswer((_) async => [ConnectivityResult.wifi]);
        when(() => mockGiphyApi.fetchGifs(any(), any()))
            .thenThrow(Exception('API error'));
        return searchBloc;
      },
      act: (bloc) => bloc.add(SearchButtonClicked(text: 'funny')),
      expect: () => [
        SearchLoadingState(),
        SearchErrorState(
            message: 'Error fetching GIFs. Please try again later.'),
      ],
    );

    blocTest<SearchBloc, SearchState>(
  'loads more gifs when LoadMoreGifs is called and the previous state is SearchLoadedSuccessState',
  build: () {
    when(() => mockConnectivity.checkConnectivity())
        .thenAnswer((_) async => [ConnectivityResult.wifi]);

    when(() => mockGiphyApi.fetchGifs(any(), 1)).thenAnswer((_) async =>
        [GifModel(id: '1', title: 'Gif 1', url: 'url1', user: ''), ...generateGifs(19)]);

    when(() => mockGiphyApi.fetchGifs(any(), 2)).thenAnswer((_) async {
      return generateGifs(20); 
    });

    return searchBloc;
  },
  act: (bloc) async {
    bloc.add(SearchButtonClicked(text: 'funny'));
    await Future.delayed(Duration(seconds: 2)); 

    bloc.add(LoadMoreGifs(text: 'funny'));
    await Future.delayed(Duration(seconds: 2)); 
  },
  wait: Duration(seconds: 3), 
  expect: () => [
    SearchLoadingState(),
    SearchLoadedSuccessState(
      gifs: [
        GifModel(id: '1', title: 'Gif 1', url: 'url1', user: ''), ...generateGifs(19)
      ],
      hasReachedMax: false, 
      gifCount: 1,
    ),
    SearchLoadedSuccessState(
      gifs: [
        GifModel(id: '1', title: 'Gif 1', url: 'url1', user: ''), ...generateGifs(19),
        ...generateGifs(20),
      ],
      hasReachedMax: false, 
      gifCount: 20,
    ),
  ],
);

    blocTest<SearchBloc, SearchState>(
      'emits SearchDetailState when GifClicked event is triggered',
      build: () {
        return searchBloc;
      },
      act: (bloc) => bloc.add(GifClicked(
          gif: GifModel(id: '1', title: 'Gif 1', url: 'url1', user: ''))),
      expect: () => [
        SearchDetailState(
            gif: GifModel(id: '1', title: 'Gif 1', url: 'url1', user: '')),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'emits SearchInitial when InitialEvent is triggered',
      build: () {
        return searchBloc;
      },
      act: (bloc) => bloc.add(InitialEvent()),
      expect: () => [
        SearchInitial(),
      ],
    );
  });
}
