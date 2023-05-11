import 'dart:convert';

import 'package:bmovie/const/appcolors.dart';
import 'package:bmovie/const/btextstyle.dart';
import 'package:bmovie/models/actingcast.dart';
import 'package:bmovie/models/moviedetail.dart';
import 'package:bmovie/models/moviegenre.dart';
import 'package:bmovie/screens/discovermovies.dart';
import 'package:bmovie/screens/movielistbygenre.dart';
import 'package:bmovie/screens/similarmovies.dart';
import 'package:bmovie/screens/tempscreen.dart';
import 'package:bmovie/widgets/imagedisplay.dart';

import 'package:bmovie/widgets/moviesmallposter.dart';
import 'package:bmovie/widgets/transparentmodal.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../const/apiroute.dart';
import '../const/appconfig.dart';
import '../models/movie.dart';
import '../services/movieservice.dart';
import '../widgets/userfeedback.dart';

class MovieDetails extends StatefulWidget {
  final Movie movie;
  const MovieDetails({super.key, required this.movie});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  final MovieService _movieService = MovieService();
  late MovieDetail _movieDetail;
  List<MovieGenre> _listOfGenresOfMovie = [];
  List<ActingCast> _listOfActingCasts = [];
  int _selectedIndex = 1;
  loadMovieDetail(int movieId) async {
    var movieDetail = await _movieService.getMovieDetail(
        APIROUTE.MovieDetail(movieId), movieId);

    setState(() {
      _movieDetail = movieDetail;
      _listOfGenresOfMovie = _movieDetail.getListOfGenres();
    });
  }

  loadActingCasts(int movieId) async {
    var listOfActingCasts = await _movieService.getActingCastsForSpecificMovie(
        APIROUTE.MovieCrewAndCast(movieId), movieId, "cast");
    setState(() {
      _listOfActingCasts = listOfActingCasts;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadMovieDetail(widget.movie.getId());
    loadActingCasts(widget.movie.getId());
  }

  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
    return Scaffold(
        //backgroundColor: bprimarycolor,
        body: SafeArea(
            child: _selectedIndex == 0
                ? Container()
                : _selectedIndex == 1
                    ? MovieMoreInfo(
                        heightOfScreen: heightOfScreen,
                        widthOfScreen: widthOfScreen,
                        movieDetails: widget,
                        listOfGenresOfMovie: _listOfGenresOfMovie,
                        listOfActingCasts: _listOfActingCasts,
                      )
                    : _selectedIndex == 2
                        ? SimilarMovies(movieId: widget.movie.getId())
                        : UserFeedback(
                            movieId: widget.movie.getId(),
                          )),
        bottomNavigationBar: CurvedNavigationBar(
            height: heightOfScreen / 16,
            color: Theme.of(context).primaryColor.withOpacity(.9),
            buttonBackgroundColor: Colors.deepOrange,
            index: 1,
            onTap: (value) => {
                  setState(() {
                    _selectedIndex = value;
                  })
                },
            backgroundColor: Colors.white,
            items: [
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TempScreen(),
                      ));
                },
              ),
              Icon(Icons.more),
              Icon(Icons.movie),
              Icon(Icons.comment)
            ]));
  }
}

class MovieMoreInfo extends StatelessWidget {
  const MovieMoreInfo({
    Key? key,
    required this.heightOfScreen,
    required this.widthOfScreen,
    required this.movieDetails,
    required List<MovieGenre> listOfGenresOfMovie,
    required List<ActingCast> listOfActingCasts,
  })  : _listOfGenresOfMovie = listOfGenresOfMovie,
        _listOfActingCasts = listOfActingCasts,
        super(key: key);

  final double heightOfScreen;
  final double widthOfScreen;
  final MovieDetails movieDetails;
  final List<MovieGenre> _listOfGenresOfMovie;
  final List<ActingCast> _listOfActingCasts;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ScreenBackgroundStack(
          heightOfScreen: heightOfScreen,
          widthOfScreen: widthOfScreen,
          image: movieDetails.movie.getImage(),
        ),
        MovieDetailBodyStack(
          heightOfScreen: heightOfScreen,
          widthOfScreen: widthOfScreen,
          heightOfBodySection: heightOfScreen / 1.33,
          movie: movieDetails.movie,
          listOfGenre: _listOfGenresOfMovie,
          listOfActingCasts: _listOfActingCasts,
        ),
        SmallMoviePosterStack(
            heightOfScreen: heightOfScreen,
            widthOfScreen: widthOfScreen,
            image: movieDetails.movie.getImage())
      ],
    );
  }
}

class ScreenBackgroundStack extends StatelessWidget {
  const ScreenBackgroundStack({
    Key? key,
    required this.heightOfScreen,
    required this.widthOfScreen,
    required this.image,
  }) : super(key: key);

  final double heightOfScreen;
  final double widthOfScreen;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Theme.of(context).backgroundColor.withOpacity(1),
                  Color.fromARGB(26, 247, 246, 246)
                ]),
          ),
          height: heightOfScreen,
          width: double.infinity,
        ),
        Positioned(
          top: 0,
          left: 0,
          child: SizedBox(
              height: heightOfScreen / 1.7,
              width: widthOfScreen,
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(heightOfScreen / 45),
                      bottomRight: Radius.circular(heightOfScreen / 45)),
                  child: ImageDisplay(
                    imageUrl: image,
                  ))),
        ),
        Positioned(
            top: 10,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ))
      ],
    );
  }
}

class MovieDetailBodyStack extends StatelessWidget {
  const MovieDetailBodyStack(
      {Key? key,
      required this.heightOfScreen,
      required this.widthOfScreen,
      required this.heightOfBodySection,
      required this.movie,
      required this.listOfGenre,
      required this.listOfActingCasts})
      : super(key: key);

  final double heightOfScreen;
  final double widthOfScreen;
  final double heightOfBodySection;
  final Movie movie;
  final List<MovieGenre> listOfGenre;
  final List<ActingCast> listOfActingCasts;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: heightOfScreen / 5,
      left: 20,
      right: 20,
      child: Container(
        height: heightOfBodySection,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            movieTitle(movie.getTitle()),
            const SizedBox(
              height: 10,
            ),
            movieRating(movie.getRating().toString()),
            const SizedBox(
              height: 10,
            ),
            MovieGenreListView(
                listOfMovieGenre: listOfGenre,
                heightOfBodySection: heightOfBodySection,
                widthOfScreen: widthOfScreen),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: SingleChildScrollView(
                    clipBehavior: Clip.antiAlias, child: movieOverview(movie))),
            const SizedBox(
              height: 10,
            ),
            movieReleaseDate(releaseDate: movie.getReleaseDate()),
            const SizedBox(
              height: 10,
            ),
            castHeader(),
            CastListView(
                listOfActingCasts: listOfActingCasts,
                heightOfBodySection: heightOfBodySection,
                widthOfScreen: widthOfScreen),
            //   Padding(
            //     padding: const EdgeInsets.all(3.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         Row(
            //           children: [
            //             Text(
            //               "Check Trailer",
            //               style: btextheader3,
            //             ),
            //             IconButton(
            //               icon: Icon(FontAwesomeIcons.eye, color: Colors.amber),
            //               onPressed: () {
            //                 Navigator.push(
            //                     context,
            //                     FullScreenModal(
            //                         child: Column(
            //                           mainAxisAlignment: MainAxisAlignment.center,
            //                           children: [
            //                             Container(
            //                                 child: Image.asset(
            //                                   movie.getImage(),
            //                                   fit: BoxFit.fill,
            //                                 ),
            //                                 width: widthOfScreen,
            //                                 height: heightOfScreen / 2,
            //                                 color: Colors.amber),
            //                           ],
            //                         ),
            //                         title: "",
            //                         description: ""));
            //               },
            //             )
            //           ],
            //         )
            //       ],
            //     ),
            //   )
          ],
        ),
      ),
    );
  }

  Padding castHeader() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text("Cast", style: btextheader2),
              Expanded(child: SizedBox()),
              Text(
                "see full cast and crew",
                style: btextheader3,
              )
            ],
          )
        ],
      ),
    );
  }

  Column movieOverview(Movie movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Text("Overview", style: btextheader2),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Text(movie.getOverview(), style: btextheader3),
        )
      ],
    );
  }

  Row movieRating(String rating) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: widthOfScreen / 4,
        ),
        Text(rating, style: btextheader2),
        const Icon(Icons.star_rate_sharp, color: Colors.deepOrange)
      ],
    );
  }

  Row movieTitle(String title) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
        width: widthOfScreen / 2.5,
      ),
      Expanded(
        child: Text(
          title,
          style: btextheader2,
        ),
      ),
    ]);
  }
}

class movieReleaseDate extends StatelessWidget {
  String releaseDate;

  movieReleaseDate({Key? key, required this.releaseDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        children: [
          const Text(
            "Release Date:",
            style: btextheader2,
          ),
          const SizedBox(
            width: 5,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(releaseDate, style: btextheader3),
          )
        ],
      ),
    );
  }
}

class MovieGenreListView extends StatelessWidget {
  const MovieGenreListView({
    Key? key,
    required this.heightOfBodySection,
    required this.widthOfScreen,
    required this.listOfMovieGenre,
  }) : super(key: key);

  final double heightOfBodySection;
  final double widthOfScreen;
  final List<MovieGenre> listOfMovieGenre;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightOfBodySection / 10,
      child: Padding(
        padding: EdgeInsets.only(left: widthOfScreen / 10, top: 10),
        child: ListView(
            scrollDirection: Axis.horizontal,
            children: listOfMovieGenre
                .map(
                  (genre) => movieGenreContainer(
                      genre: genre, widthOfScreen: widthOfScreen),
                )
                .toList()),
      ),
    );
  }
}

class movieGenreContainer extends StatelessWidget {
  final MovieGenre genre;
  final double widthOfScreen;
  const movieGenreContainer(
      {super.key, required this.genre, required this.widthOfScreen});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieListByGenre(genre: genre)))
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: widthOfScreen / 4,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.deepOrange.withOpacity(.5),
              border: Border.all(width: 1, color: Colors.purple),
              borderRadius: BorderRadius.circular(30)),
          child: Text(genre.getName(), style: btextheader3),
        ),
      ),
    );
  }
}

class CastListView extends StatelessWidget {
  const CastListView(
      {Key? key,
      required this.heightOfBodySection,
      required this.widthOfScreen,
      required this.listOfActingCasts})
      : super(key: key);

  final double heightOfBodySection;
  final double widthOfScreen;
  final List<ActingCast> listOfActingCasts;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightOfBodySection / 4.2,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: listOfActingCasts
            .map((cast) => castColumn(
                cast: cast,
                widthOfScreen: widthOfScreen,
                heightOfBodySection: heightOfBodySection))
            .toList(),
      ),
    );
  }
}

class castColumn extends StatelessWidget {
  final ActingCast cast;

  final double widthOfScreen;

  final double heightOfBodySection;

  const castColumn({
    super.key,
    required this.cast,
    required this.widthOfScreen,
    required this.heightOfBodySection,
  });

  void showBottomSheetModal(BuildContext context, ActingCast cast) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var heightOfContainer = heightOfScreen / 2;
    showModalBottomSheet(
        context: context,
        builder: (context) => Stack(children: [
              Container(
                color: Colors.black54,

                height: heightOfContainer,
                //      color: Colors.green,
              ),
              Positioned(
                  top: heightOfContainer / 5,
                  left: 0,
                  child: Container(
                    width: widthOfScreen,
                    height: heightOfContainer,
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    child: Padding(
                      padding: EdgeInsets.only(top: heightOfContainer / 4),
                      child: Column(
                        children: [
                          Text(cast.getName(), style: btextheader2),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text("as", style: btextheader2),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            cast.getCharacterName(),
                            style: btextheader2,
                          )
                        ],
                      ),
                    ),
                  )),
              Positioned(
                  top: heightOfContainer / 13,
                  left: widthOfScreen / 2 - (widthOfScreen / 6),
                  child: Container(
                    height: heightOfContainer / 3,
                    width: widthOfScreen / 3,
                    decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.purple),
                      image: DecorationImage(
                          image: NetworkImage(cast.getProfilePath()),
                          fit: BoxFit.cover),
                      //color: Colors.blue,
                      borderRadius:
                          BorderRadius.circular(heightOfContainer / 6),
                    ),
                  ))
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => showBottomSheetModal(context, cast),
              child: SizedBox(
                  width: widthOfScreen / 4.2,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ImageDisplay(imageUrl: cast.getProfilePath()))
                  //   Image.network(cast.getProfilePath(), fit: BoxFit.fill)),
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              child: Text(
                cast.getName(),
                style: btextheader3,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SmallMoviePosterStack extends StatelessWidget {
  const SmallMoviePosterStack({
    Key? key,
    required this.heightOfScreen,
    required this.widthOfScreen,
    required this.image,
  }) : super(key: key);

  final double heightOfScreen;
  final double widthOfScreen;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: heightOfScreen / 10,
        left: widthOfScreen / 10,
        child: MovieSmallPoster(
            imagePath: image,
            //  height: heightOfScreen / 5,
            width: widthOfScreen / 3.7));
  }
}
