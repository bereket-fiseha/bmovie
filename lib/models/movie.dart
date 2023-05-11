// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:bmovie/const/appconfig.dart';
import 'package:bmovie/interface/IJsonBase.dart';

import '../const/apiroute.dart';

class Movie {
  final int _id;
  final String _title;
  final String _overview;
  final double _rating;
  final String _image;
  final String _releaseDate;

  String getTitle() => _title;

  String getOverview() => _overview;

  double getRating() => _rating;

  int getId() => _id;
  String getImage() =>
      AppConfig.local == true ? _image : "${APIROUTE.imageBaseUrl}${_image}";

  String getReleaseDate() => _releaseDate;
  Movie(
      {required int id,
      required String title,
      required String overview,
      required double rating,
      required String image,
      required String releaseDate})
      : _title = title,
        _image = image,
        _overview = overview,
        _releaseDate = releaseDate,
        _rating = rating,
        _id = id;

  @override
  void toJson() => {
        "title": _title,
        "overview": _overview,
        "rating": _rating,
        "image": _image,
        "releaseDate": _releaseDate
      };
  @override
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json["id"],
        title: json["title"] ?? "",
        overview: json["overview"] ?? "",
        rating:
            json["vote_average"] == null ? 0 : json["vote_average"].toDouble(),
        image: json["poster_path"] ?? "",
        releaseDate: json["release_date"] ?? "");
  }
}
