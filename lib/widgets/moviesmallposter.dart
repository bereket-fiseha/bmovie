import 'package:bmovie/widgets/imagedisplay.dart';
import 'package:flutter/material.dart';

import '../const/apiroute.dart';
import '../const/appconfig.dart';

class MovieSmallPoster extends StatelessWidget {
  const MovieSmallPoster({
    Key? key,
    required this.width,
    required this.imagePath,
  }) : super(key: key);

  final double width;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
          width: width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
                color: Theme.of(context).backgroundColor.withOpacity(.6),
                child: ImageDisplay(
                  imageUrl: imagePath,
                )),
          )),
    );
  }
}
