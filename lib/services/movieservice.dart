import 'dart:convert';

import 'package:bmovie/const/apiroute.dart';
import 'package:bmovie/const/appconfig.dart';
import 'package:bmovie/interface/imovieservice.dart';
import 'package:bmovie/models/actingcast.dart';
import 'package:bmovie/models/moviedetail.dart';
import 'package:bmovie/utils/jsonops.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class MovieService implements IMovieService {
  final JsonOps _jsonOps = JsonOps();

  @override
  Future<List<Movie>> getAllMovies(String url) async {
    var jsonString = await http.get(Uri.parse(url));
    return _jsonOps.deserilizeMovie(jsonString.body, "results");
  }

  @override
  Future<List<Movie>> getAllMoviesFilteredByGenre(
      String url, String key) async {
    var jsonString = await http.get(Uri.parse(url));
    debugPrint(url);
    debugPrint(jsonString.toString());
    return _jsonOps.deserilizeMovie(jsonString.body, key);
  }

  @override
  Future<List<Movie>> getAllMoviesSearchedByTerm(String url, String key) async {
    var jsonString = await http.get(Uri.parse(url));
    return _jsonOps.deserilizeMovie(jsonString.body, key);
  }

  Future<List<Movie>> getAllMoviesFiltered(
      String url, String key, dynamic value) async {
    url = "$url?$key=$value&api_key=${AppConfig.api_key}";
    var jsonString = await http.get(Uri.parse(url));
    return _jsonOps.deserilizeMovie(jsonString.body, "results");
  }

  Future<MovieDetail> getMovieDetail(String url, int id) async {
    var jsonString = await http.get(Uri.parse(url));
    // var jsonString =
    //   await rootBundle.loadString("assets/images/movie/moviedetail.json");

    // return _jsonOps.deserilizeMovieDetail(jsonString.body, null);
    return _jsonOps.deserilizeMovieDetail(jsonString.body, null);
  }

  @override
  Future<List<ActingCast>> getActingCastsForSpecificMovie(
      String url, int id, String key) async {
    var jsonString = await http.get(Uri.parse(url));
    // return _jsonOps.deserilizeMovieDetail(jsonString.body, null);
    // var jsonString =
    //    await rootBundle.loadString("assets/images/movie/moviecrew.json");
    return _jsonOps.deserilizeActingCast(jsonString.body, key);
  }

  @override
  Future<List<Movie>> getRecommendedMovies(int movieId, String key) async {
    String url = APIROUTE.RecommendedMovies(movieId);
    var jsonString = await http.get(Uri.parse(url));
    return _jsonOps.deserilizeMovie(jsonString.body, key);
  }

  @override
  Future<List<Movie>> getSimilarMovies(int movieId, String key) async {
    String url = APIROUTE.SimilarMovies(movieId);
    var jsonString = await http.get(Uri.parse(url));
    return _jsonOps.deserilizeMovie(jsonString.body, key);
  }

  @override
  Future<List<String>> getReviews(int movieId, String key) async {
    String url = APIROUTE.MovieReviews(movieId);
    var jsonString = await http.get(Uri.parse(url));
    return _jsonOps.deserilizeString(jsonString.body, key);
  }

  List<Movie> getFilteredLocalMovieList(bool Function(Movie) test) {
    return getLocalMovieList().where(test).toList();
  }

  List<Movie> getLocalMovieList() {
    return movieList;
  }

  List<String> getLocalUserReviews() {
    return reviews;
  }

  List<String> reviews = [
    "its greate movie! , its greate movie!,its greate movie! its greate movie!, its greate movie!,its greate movie! its greate movie!,its greate movie!,its greate movie!"
  ];

  List<Movie> movieList = [
    Movie(
        id: 1,
        title: "avengers",
        overview: "this is the overview of the movie",
        rating: 5.5,
        image: "assets/images/movie/encanto.jpg",
        releaseDate: "12-2-2022"),
    Movie(
        id: 2,
        title: "avengers two",
        overview: "this is the overview of the movie",
        rating: 6.5,
        image: "assets/images/movie/bigfour.jpg",
        releaseDate: "12-2-2022"),
    Movie(
        id: 3,
        title: "wakanda",
        overview: "this is the overview of the movie",
        rating: 7.5,
        image: "assets/images/movie/arizona.jpg",
        releaseDate: "9-3-2022"),
    Movie(
        id: 4,
        title: "the adam",
        overview: "this is the overview of the movie",
        rating: 6.5,
        image: "assets/images/movie/roadaway.jpg",
        releaseDate: "9-3-2020"),
    Movie(
        id: 5,
        title: "I know what you did last summer",
        overview: "this is the overview of the movie",
        rating: 5.5,
        image: "assets/images/movie/threefriends.jpg",
        releaseDate: "9-3-2020"),
    Movie(
        id: 6,
        title: "The movie",
        overview: "this is the overview of the movie",
        rating: 5.5,
        image: "assets/images/movie/chaplin.jpg",
        releaseDate: "19-3-2020"),
  ];
}
