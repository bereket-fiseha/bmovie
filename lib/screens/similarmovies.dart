import 'package:bmovie/const/apiroute.dart';
import 'package:bmovie/const/appconfig.dart';
import 'package:bmovie/const/btextstyle.dart';
import 'package:bmovie/models/movie.dart';
import 'package:bmovie/services/movieservice.dart';
import 'package:bmovie/utils/stringops.dart';
import 'package:bmovie/widgets/imagedisplay.dart';
import 'package:bmovie/widgets/listtilemoviecontainer.dart';
import 'package:bmovie/widgets/moviesmallposter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SimilarMovies extends StatefulWidget {
  int movieId;
  SimilarMovies({super.key, required this.movieId});
  @override
  State<SimilarMovies> createState() => _SimilarMoviesState();
}

class _SimilarMoviesState extends State<SimilarMovies> {
  List<Movie> listOfSimilarMovies = [];
  List<Movie> listOfRecommendedMovies = [];
  List<Movie> listOfUserFeedbacks = [];

  MovieService _movieService = MovieService();
  @override
  void initState() {
    // TODO: implement initState
    loadSimilarMovies(widget.movieId);
    loadRecommendedMovies(widget.movieId);
  }

  void loadSimilarMovies(int movieId) async {
    listOfSimilarMovies = !AppConfig.local
        ? await _movieService.getSimilarMovies(movieId, "results")
        : _movieService.getLocalMovieList();
  }

  void loadRecommendedMovies(int movieId) async {
    listOfSimilarMovies = !AppConfig.local
        ? await _movieService.getRecommendedMovies(movieId, "results")
        : _movieService.getLocalMovieList();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      body: ListView(
        children: [
          MovieTrailorAndSimilarMovie(
            height: height,
            width: width,
            movies: listOfSimilarMovies,
          ),
          const SizedBox(
            height: 15,
          ),
          Recomendation(
              movies: listOfRecommendedMovies, height: height, width: width),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    ));
  }
}

class Recomendation extends StatelessWidget {
  const Recomendation({
    Key? key,
    required this.movies,
    required this.height,
    required this.width,
  }) : super(key: key);

  final List<Movie> movies;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpansionTile(
            collapsedBackgroundColor: Colors.indigo.withOpacity(0.5),
            collapsedIconColor: Colors.white,
            initiallyExpanded: true,
            title: Text(
              "Recommended",
              style: btextheader2,
            ),
            subtitle: Text("movies that are recommended for you."),
            children: movies
                .map((movie) => ListTileMovieContainer(
                    movie: movie, height: height / 6, widthOfImage: width / 3))
                .toList()),
      ],
    );
  }
}

class MovieTrailorAndSimilarMovie extends StatelessWidget {
  const MovieTrailorAndSimilarMovie(
      {Key? key,
      required this.height,
      required this.width,
      required this.movies})
      : super(key: key);

  final double height;
  final double width;
  final List<Movie> movies;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 2 * height / 2.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TrailorVideoWidget(height: height),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Similar Movies",
                style: btextheader2,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
                child: SimilarMoviesListView(
              height: height,
              width: width,
              listOfMovies: movies,
            ))
          ],
        ));
  }
}

class TrailorVideoWidget extends StatelessWidget {
  const TrailorVideoWidget({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(height: height / 2.2, color: Colors.amber);
  }
}

class SimilarMoviesListView extends StatelessWidget {
  const SimilarMoviesListView(
      {Key? key,
      required this.width,
      required this.height,
      required this.listOfMovies})
      : super(key: key);

  final double width;
  final List<Movie> listOfMovies;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: listOfMovies
            .map((movie) => Column(
                  children: [
                    Expanded(
                      child: Stack(children: [
                        MovieSmallPoster(
                            width: width / 3, imagePath: movie.getImage()),
                        Positioned(
                            top: 0,
                            left: 0,
                            child: FractionalTranslation(
                              translation: Offset(-0.1, 0),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.deepPurple,
                                //   backgroundColor: Color.fromARGB(255, 129, 120, 120),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      movie.getRating().toString(),
                                      style: btextheader3,
                                    ),
                                    Icon(Icons.star,
                                        size: 13, color: Colors.deepOrange),
                                  ],
                                ),
                              ),
                            ))
                      ]),
                    ),
                    Text(
                      StringOps.shortenString(movie.getTitle(), 12),
                      style: btextheader3,
                    )
                  ],
                ))
            .toList(),
      ),
    );
  }
}
