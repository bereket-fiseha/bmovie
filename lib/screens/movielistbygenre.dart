import 'package:bmovie/const/apiroute.dart';
import 'package:bmovie/const/appcolors.dart';
import 'package:bmovie/const/btextstyle.dart';
import 'package:bmovie/models/moviegenre.dart';
import 'package:bmovie/services/movieservice.dart';
import 'package:bmovie/widgets/moviesmallposter.dart';

import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../utils/stringops.dart';

class MovieListByGenre extends StatefulWidget {
  final MovieGenre genre;

  const MovieListByGenre({super.key, required this.genre});

  @override
  State<MovieListByGenre> createState() => _MovieListByGenreState();
}

class _MovieListByGenreState extends State<MovieListByGenre> {
  late MovieService _movieService;
  List<Movie> _listOfMoviesByGenre = [];
  @override
  void initState() {
    // TODO: implement initState

    _movieService = MovieService();
    loadAllMoviesByGenre();
  }

  void loadAllMoviesByGenre() async {
    List<Movie> movies = await _movieService.getAllMoviesFilteredByGenre(
        APIROUTE.ListOfMoviesByGenre(widget.genre.getId()), "results");
    setState(() {
      _listOfMoviesByGenre = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
    // var movie = Movie(
    //     id: 2,
    //     image: "assets/images/movie/bigfour.jpg",
    //     title: "Big Four",
    //     overview: "this is the detail of the movie in this and i think",
    //     rating: 6.5,
    //     releaseDate: "2-10-2022");

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.genre.getName()),
      ),
      body: ListView(
        children: _listOfMoviesByGenre
            .map((movie) => MovieDetailListTileStack(
                heightOfScreen: heightOfScreen,
                widthOfScreen: widthOfScreen,
                movie: movie))
            .toList(),
        //   children: [
        //     MovieDetailListTileStack(
        //         heightOfScreen: heightOfScreen,
        //         widthOfScreen: widthOfScreen,
        //         movie: movie),
        //     MovieDetailListTileStack(
        //         heightOfScreen: heightOfScreen,
        //         widthOfScreen: widthOfScreen,
        //         movie: movie),
        //     MovieDetailListTileStack(
        //         heightOfScreen: heightOfScreen,
        //         widthOfScreen: widthOfScreen,
        //         movie: movie),
        //     MovieDetailListTileStack(
        //         heightOfScreen: heightOfScreen,
        //         widthOfScreen: widthOfScreen,
        //         movie: movie),
        //     MovieDetailListTileStack(
        //         heightOfScreen: heightOfScreen,
        //         widthOfScreen: widthOfScreen,
        //         movie: movie)
        //   ],
      ),
    );
  }
}

class MovieDetailListTileStack extends StatelessWidget {
  final double heightOfScreen;
  final double widthOfScreen;
  final Movie movie;

  const MovieDetailListTileStack(
      {super.key,
      required this.heightOfScreen,
      required this.widthOfScreen,
      required this.movie});

  @override
  Widget build(BuildContext context) {
    var heightOfContainer = heightOfScreen / 4;

    return Stack(children: [
      Container(
        height: heightOfContainer,
        width: widthOfScreen,
      ),
      Positioned(
          top: heightOfContainer / 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              height: heightOfContainer / 1.5,
              width: widthOfScreen - 20,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: Theme.of(context).backgroundColor.withOpacity(.5)),
                  borderRadius: BorderRadius.circular(10)),
              alignment: Alignment.center,
              child: Column(children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: widthOfScreen / 3,
                    ),
                    Text(
                      StringOps.shortenString(movie.getTitle(), 20),
                      style: btextheader2,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: widthOfScreen / 2.8,
                    ),
                    Text(movie.getRating().toString(), style: btextheader2),
                    const Icon(Icons.star, color: Colors.deepOrange)
                  ],
                )
              ]),
            ),
          )),
      Positioned(
          top: 0,
          left: 10,
          child: Container(
            height: heightOfContainer / 1.13,
            child: MovieSmallPoster(
                width: widthOfScreen / 3.6, imagePath: movie.getImage()),
          ))
    ]);
  }
}
