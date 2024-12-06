import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gif_with_bloc/API/giphy_api.dart';
import 'package:gif_with_bloc/model/gif_model.dart';
import 'package:gif_with_bloc/search/bloc/search_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGiphyApi extends Mock implements GiphyApi {}
class MockConnectivity extends Mock implements Connectivity {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockGiphyApi mockGiphyApi;
  late MockConnectivity mockConnectivity;
  late List<GifModel> gifs;
  

  gifs = [
    GifModel(
      id: '1',
      title: 'Funny Cat',
      url: 'https://example.com/1.gif',
      user: 'User1',
    ),
    GifModel(
      id: '2',
      title: 'Funny Dog',
      url: 'https://example.com/2.gif',
      user: 'User2',
    ),
  ];

    
    mockGiphyApi = MockGiphyApi();
    mockConnectivity = MockConnectivity();

    // Mock checkConnectivity() to return a list
    //when(() => mockConnectivity.checkConnectivity()).thenAnswer((_) async => [ConnectivityResult.none]);
    // Mock the API response
    when(() => mockGiphyApi.fetchGifs(any(), any())).thenAnswer((_) async => gifs);
 

  group('SearchBloc Tests', () {
    blocTest<SearchBloc, SearchState>(
      'Returns GIF detail state when a GIF is clicked',
      build: () => SearchBloc(giphyApi: mockGiphyApi, connectivity: mockConnectivity),
      act: (bloc) => bloc.add(GifClicked(gif: gifs[1])), 
      expect: () => <SearchState>[
        SearchDetailState(gif: gifs[1]),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'Emits SearchErrorState when there is no internet connection on SearchButtonClicked event',
      build: () {
        // Override connectivity status for this test
        when(() => mockConnectivity.checkConnectivity()).thenAnswer((_) async => [ConnectivityResult.none]);
        return SearchBloc(giphyApi: mockGiphyApi, connectivity: mockConnectivity);
      },
      act: (bloc) => bloc.add(SearchButtonClicked(text: 'cat')),
      wait: const Duration(milliseconds: 500),
      expect: () => <SearchState>[
        SearchErrorState(message: 'No internet connection.'),
      ],
    );
  });
}
