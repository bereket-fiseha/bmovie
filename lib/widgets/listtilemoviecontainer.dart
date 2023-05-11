import 'package:flutter/material.dart';

import '../const/btextstyle.dart';
import '../models/movie.dart';
import '../utils/stringops.dart';
import 'imagedisplay.dart';

class ListTileMovieContainer extends StatelessWidget {
  final Movie movie;
  final double height;
  final double widthOfImage;
  ListTileMovieContainer(
      {required this.movie, required this.height, required this.widthOfImage});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height,
        //  height: heightOfScreen / 5,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border:
              Border.all(color: Color.fromARGB(255, 171, 129, 178), width: 1),
        ),
        child: Row(
          children: [
            Container(
                width: widthOfImage,
                // width: widthOfScreen / 2.5,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ImageDisplay(imageUrl: movie.getImage()))),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Title: ${StringOps.shortenString(movie.getTitle(), 20)}",
                  style: btextheader3,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Rating: ${movie.getRating().toStringAsFixed(1)}",
                      style: btextheader3,
                    ),
                    Icon(Icons.star, color: Colors.deepOrange)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Release Date: ${movie.getReleaseDate()}",
                    style: btextheader3)
              ],
            )
          ],
        ),
      ),
    );
  }
}
