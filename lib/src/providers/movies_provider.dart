import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:movies/src/models/movie_model.dart';

class MoviesProvider {
  String _apiKey = '7bc954512879543a094fe82fcff8f7c1';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  int _popularPage = 0;

  List<Movie> _mostPopularMovies = new List();

  final _mostPopularMoviesStreamController =
      StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get mostPopularMoviesSink =>
      _mostPopularMoviesStreamController.sink.add;

  Stream<List<Movie>> get mostPopularMoviesStream =>
      _mostPopularMoviesStreamController.stream;

  void disposeStreams() {
    _mostPopularMoviesStreamController?.close();
  }

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

  Future<List<Movie>> getMostPopularMovies() async {
    _popularPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularPage.toString(),
    });
    final response = await _getResponse(url);

    _mostPopularMovies.addAll(response);
    mostPopularMoviesSink(_mostPopularMovies);

    return response;
  }
}
