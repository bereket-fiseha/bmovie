import 'package:bmovie/const/btextstyle.dart';
import 'package:bmovie/screens/moviedetail.dart';
import 'package:bmovie/widgets/imagedisplay.dart';

import 'package:flutter/material.dart';

import '../models/movie.dart';

class ListWheelImageSlider extends StatefulWidget {
  final List<Movie> listOfMovies;
  final double height;
  final double width;
  final Color color;

  ListWheelImageSlider(
      {required this.listOfMovies,
      required this.height,
      required this.color,
      required this.width});

  @override
  State<ListWheelImageSlider> createState() => _ListWheelImageSliderState();
}

class _ListWheelImageSliderState extends State<ListWheelImageSlider> {
  late Movie _selectedMovie;
  @override
  void initState() {
    // TODO: implement initState

    _selectedMovie = widget.listOfMovies[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: Column(
        children: [
          Expanded(
            child: RotatedBox(
              quarterTurns: -45,
              child: ListWheelScrollView(
                onSelectedItemChanged: (index) => {
                  setState(() {
                    _selectedMovie = widget.listOfMovies[index];
                  })
                },
                itemExtent: widget.width * 0.65,
                children: widget.listOfMovies
                    .map((movie) => RotatedBox(
                          quarterTurns: 45,
                          child: SizedBox(
                            height: widget.height * 0.8,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: ImageDisplay(
                                imageUrl: movie.getImage(),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          SizedBox(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _selectedMovie.getTitle(),
                style: btextheader2,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                _selectedMovie.getRating().toString(),
                style: btextheader2,
              ),
              Icon(
                Icons.star,
                size: 30,
                color: Colors.deepOrange,
              )
            ],
          ))
        ],
      ),
    );
  }
}
