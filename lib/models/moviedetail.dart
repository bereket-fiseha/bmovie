import 'package:bmovie/models/moviegenre.dart';

import '../const/apiroute.dart';
import '../const/appconfig.dart';

class MovieDetail {
  final String _title;
  final String _overview;
  final double _rating;
  final String _image;
  final String _releaseDate;
  final List<MovieGenre> _listOfGenres;
  String getTitle() => _title;

  String getOverview() => _overview;

  double getRating() => _rating;

  String getImage() =>
      AppConfig.local == true ? _image : "${APIROUTE.imageBaseUrl}${_image}";

  String getReleaseDate() => _releaseDate;

  List<MovieGenre> getListOfGenres() => _listOfGenres;
  MovieDetail(
      {required String title,
      required String overview,
      required double rating,
      required String image,
      required String releaseDate,
      required List<MovieGenre> listOfGenres})
      : _title = title,
        _image = image,
        _overview = overview,
        _releaseDate = releaseDate,
        _rating = rating,
        _listOfGenres = listOfGenres;

  @override
  void toJson() => {
        "title": _title,
        "overview": _overview,
        "rating": _rating,
        "image": _image,
        "releaseDate": _releaseDate
      };
  @override
  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
        title: json["title"],
        overview: json["overview"],
        rating: json["vote_average"].toDouble(),
        image: json["poster_path"],
        releaseDate: json["release_date"],
        listOfGenres: List<MovieGenre>.from(json["genres"]
            .map((x) => MovieGenre(id: x["id"], name: x["name"]))));
  }
}
