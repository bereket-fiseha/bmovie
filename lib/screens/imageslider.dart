import 'package:bmovie/const/btextstyle.dart';
import 'package:bmovie/models/enum.dart';
import 'package:bmovie/services/movieservice.dart';
import 'package:bmovie/widgets/cardsliderwidget.dart';
import 'package:bmovie/widgets/listwheelimageslider.dart';
import 'package:card_slider/card_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';

class ImageSlider extends StatelessWidget {
  List<Movie> listOfMovies;
  String title;
  SliderType sliderType;
  ImageSlider(
      {required this.listOfMovies,
      required this.sliderType,
      required this.title});

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var color = Color.fromARGB(255, 132, 131, 131);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Movie Slider"),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    title,
                    style: btextheader2,
                  ),
                ),
              ],
            ),
            sliderType == SliderType.ListWheel
                ? Expanded(
                    child: Center(
                      child: ListWheelImageSlider(
                        listOfMovies: listOfMovies,
                        height: height / 1.5,
                        width: width,
                        color: color,
                      ),
                    ),
                  )
                : Expanded(
                    child: Center(
                      child: CardSliderWidget(
                        listOfMovies: listOfMovies,
                        height: height / 1.5,
                        width: width,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
