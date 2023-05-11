import 'package:bmovie/const/btextstyle.dart';
import 'package:bmovie/screens/moviedetail.dart';
import 'package:bmovie/widgets/moviecard.dart';
import 'package:card_slider/card_slider.dart';

import 'package:flutter/material.dart';

import '../models/movie.dart';

class CardSliderWidget extends StatefulWidget {
  final List<Movie> listOfMovies;
  final double height;
  final double width;

  CardSliderWidget(
      {required this.listOfMovies, required this.height, required this.width});

  @override
  State<CardSliderWidget> createState() => _CardSliderWidgetState();
}

class _CardSliderWidgetState extends State<CardSliderWidget> {
  late Movie _selectedMovie;
  @override
  void initState() {
    // TODO: implement initState

    _selectedMovie = widget.listOfMovies[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CardSlider(
          bottomOffset: .0005,
          itemDotOffset: 0.5,
          cards: widget.listOfMovies
              .map((movie) => MovieCard(
                  movie: movie,
                  heightOfCard: widget.height,
                  widthOfCard: widget.width))
              .toList()),
    );
  }
}
