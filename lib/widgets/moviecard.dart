import 'package:bmovie/const/btextstyle.dart';
import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../utils/stringops.dart';
import 'imagedisplay.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final double heightOfCard;
  final double widthOfCard;
  const MovieCard(
      {super.key,
      required this.movie,
      required this.heightOfCard,
      required this.widthOfCard});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: widthOfCard,
        height: heightOfCard,
        color: Color.fromARGB(255, 213, 204, 118),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                  width: widthOfCard,
                  child: ImageDisplay(
                    imageUrl: movie.getImage(),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    StringOps.shortenString(movie.getTitle(), 15),
                    style: btextheader2,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    movie.getRating().toString(),
                    style: btextheader2,
                  ),
                  Icon(
                    Icons.star,
                    size: 30,
                    color: Colors.deepOrange,
                  )
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
