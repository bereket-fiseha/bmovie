import 'package:bmovie/models/actingcast.dart';

import '../models/movie.dart';
import '../models/moviedetail.dart';

abstract class IMovieService {
  Future<List<Movie>> getAllMovies(String url);

  Future<MovieDetail> getMovieDetail(String url, int id);

  Future<List<Movie>> getAllMoviesFilteredByGenre(String url, String key);

  Future<List<Movie>> getSimilarMovies(int movieId, String key);
  Future<List<Movie>> getRecommendedMovies(int movieId, String key);
  Future<List<String>> getReviews(int movieId, String key);

  Future<List<ActingCast>> getActingCastsForSpecificMovie(
      String url, int id, String key);
}
