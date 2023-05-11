import 'dart:convert';

import 'package:bmovie/interface/ijsonops.dart';
import 'package:bmovie/models/actingcast.dart';
import 'package:bmovie/models/movie.dart';
import 'package:flutter/cupertino.dart';

import '../interface/IJsonBase.dart';
import '../models/moviedetail.dart';

class JsonOps {
  List<Movie> deserilizeMovie(String jsonString, String? key) {
    List<dynamic> listOfJsonObjects =
        key != null ? jsonDecode(jsonString)[key] : jsonDecode(jsonString);

    return listOfJsonObjects
        .map<Movie>((object) => Movie.fromJson(object))
        .toList();
  }

  MovieDetail deserilizeMovieDetail(String jsonString, String? key) {
    Map<String, dynamic> jsonObject =
        key != null ? jsonDecode(jsonString)[key] : jsonDecode(jsonString);
    var movieDetail = MovieDetail.fromJson(jsonObject);

    return movieDetail;
  }

  List<ActingCast> deserilizeActingCast(String jsonString, String? key) {
    List<dynamic> listOfJsonObjects =
        key != null ? jsonDecode(jsonString)[key] : jsonDecode(jsonString);
    return listOfJsonObjects
        .map((object) => ActingCast.fromJson(object))
        .toList();
  }

  List<String> deserilizeString(String jsonString, String? key) {
    List<dynamic> listOfJsonObjects =
        key != null ? jsonDecode(jsonString)[key] : jsonDecode(jsonString);
    return listOfJsonObjects.map((strn) => strn.toString()).toList();
  }
}
