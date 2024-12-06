import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/gif_model.dart';

class GiphyApi {
  static const String _apiKey = '0f1xWSqDaoFEZN7E2XUU8TiMJ6tb2JMJ';

  static const String _baseUrl = 'https://api.giphy.com/v1/gifs/search';

  Future<List<GifModel>> fetchGifs(String query, int page) async {
    final limit = 20;
    final offset = (page - 1) * limit;

    try {
      final response = await http.get(Uri.parse(
          '$_baseUrl?api_key=$_apiKey&q=$query&limit=$limit&offset=$offset'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> gifsJson = data['data'];
        print('Fetched GIFs (giphy_api.dart)');
        List<GifModel> gifs = [];
        for (var gif in gifsJson) {
          gifs.add(GifModel.fromJson(gif));
        }
        return gifs;
      } else {
        print('Error fetching GIFs: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load GIFs');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to load GIFs');
    }
  }
}