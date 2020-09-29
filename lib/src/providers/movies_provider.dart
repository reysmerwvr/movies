import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:movies/src/models/movie_model.dart';

class MoviesProvider {
  String _apiKey = '7bc954512879543a094fe82fcff8f7c1';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  Future<List<Movie>> _getResponse(Uri url) async {
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final movies = new Movies.fromJsonList(decodedData['results']);
    return movies.items;
  }

  Future<List<Movie>> nowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });
    return await _getResponse(url);
  }

  Future<List<Movie>> getMostPopular() async {
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
    });
    return await _getResponse(url);
  }
}
