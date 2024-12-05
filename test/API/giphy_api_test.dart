import 'package:flutter_test/flutter_test.dart';
import 'package:gif_with_bloc/model/gif_model.dart';
import 'package:gif_with_bloc/API/giphy_api.dart';

void main() {
  GiphyApi giphyApi = GiphyApi();
  test("Api call returns gifs", () async {
    Future<List<GifModel>> gifs = giphyApi.fetchGifs('cats', 1);
    List<GifModel> gifList = await gifs;
    expect(gifList, isNotEmpty);
  });
}
