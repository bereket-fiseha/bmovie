import 'package:bmovie/const/appconfig.dart';
import 'package:bmovie/screens/similarmovies.dart';

class APIROUTE {
  static String Now_Playing =
      "https://api.themoviedb.org/3/movie/now_playing?api_key=${AppConfig.api_key}&language=en-US&page=1";
  static String Discover = "";
  static String Top_Rated =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=${AppConfig.api_key}&language=en-US&page=1";
  static String Popular =
      "https://api.themoviedb.org/3/movie/popular?api_key=${AppConfig.api_key}&language=en-US&page=1";
  static String MovieDetail(int movieId) =>
      "https://api.themoviedb.org/3/movie/$movieId?api_key=${AppConfig.api_key}&language=en-US&page=1";
  static String imageBaseUrl = "https://image.tmdb.org/t/p/w500";
  static String MovieCrewAndCast(int movieId) =>
      "https://api.themoviedb.org/3/movie/$movieId/credits?api_key=${AppConfig.api_key}&language=en-US&page=1";
  static String SimilarMovies(int movieId) =>
      "https://api.themoviedb.org/3/movie/$movieId/similar?api_key=${AppConfig.api_key}&language=en-US&page=1";
  static String RecommendedMovies(int movieId) =>
      "https://api.themoviedb.org/3/movie/$movieId/recommendations?api_key=${AppConfig.api_key}&language=en-US&page=1";

  static String MovieReviews(int movieId) =>
      "https://api.themoviedb.org/3/movie/$movieId/reviews?api_key=${AppConfig.api_key}&language=en-US&page=1";

  static String ListOfMoviesByGenre(int id) =>
      "https://api.themoviedb.org/3/discover/movie?api_key=${AppConfig.api_key}&with_genres=$id";

  static String searchMovie(String term) =>
      "https://api.themoviedb.org/3/search/movie?api_key=${AppConfig.api_key}&query=${term}&language=en-US&page=1";
}
