import 'dart:ui';

import 'package:bmovie/const/apiroute.dart';
import 'package:bmovie/const/btextstyle.dart';
import 'package:bmovie/services/movieservice.dart';
import 'package:bmovie/widgets/imagedisplay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../const/appconfig.dart';
import '../models/movie.dart';
import '../utils/stringops.dart';

class MovieSearch extends StatefulWidget {
  String? term;
  MovieSearch({super.key, this.term});

  @override
  State<MovieSearch> createState() => _MovieSearchState();
}

class _MovieSearchState extends State<MovieSearch> {
  late final MovieService _movieService;
  late final TextEditingController _searchTextController;
  List<Movie> _movies = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _movieService = MovieService();

    _searchTextController = TextEditingController(text: widget.term);
    loadMovies(widget.term ?? "");
  }

  void loadMovies(String term) async {
    var movies = AppConfig.local
        ? _movieService.getLocalMovieList()
        : await _movieService.getAllMoviesSearchedByTerm(
            APIROUTE.searchMovie(term), "results");

    setState(() {
      _movies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;

    var widthOfScreen = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("search movie"),
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchTextController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: Colors.amber), //<-- SEE HERE

                            borderRadius: BorderRadius.circular(30)),
                        hintText: 'Search for movie',
                        prefixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            loadMovies(_searchTextController.text);
                          },
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              _searchTextController.text = "";
                            },
                            icon: const Icon(Icons.close))),
                  ),
                ),
                Expanded(
                  child: _searchTextController.text == ""
                      ? Center(
                          child: Text(
                          "Search Movies...",
                          style: btextheader1,
                        ))
                      : _searchTextController.text.isNotEmpty && _movies.isEmpty
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: _movies.length,
                              itemBuilder: (context, index) =>
                                  CardMovieContainer(
                                      movie: _movies[index],
                                      height: heightOfScreen / 3,
                                      width: widthOfScreen)),
                ),
              ],
            )));
  }
}

class CardMovieContainer extends StatelessWidget {
  final Movie movie;
  final double height;
  final double width;
  const CardMovieContainer(
      {super.key,
      required this.movie,
      required this.height,
      required this.width});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: width / 15, vertical: height / 20),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 2, color: Colors.deepPurple)),
        child: Stack(
          children: [
            Card(
              child: Column(children: [
                Expanded(
                    child: SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: ImageDisplay(
                      imageUrl: movie.getImage(),
                    ),
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${StringOps.shortenString(movie.getTitle(), 10)}",
                        style: btextheader3,
                      ),
                      Row(
                        children: [
                          Icon(Icons.date_range, color: Colors.yellow),
                          Text(
                            " ${movie.getReleaseDate()}",
                            style: btextheader3,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ]),
            ),
            Positioned(
                top: 0,
                right: 0,
                child: FractionalTranslation(
                  translation: Offset(0.3, -0.3),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.deepPurple,
                    //   backgroundColor: Color.fromARGB(255, 129, 120, 120),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          movie.getRating().toStringAsFixed(1),
                          style: btextheader3,
                        ),
                        Icon(Icons.star, size: 25, color: Colors.deepOrange),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
