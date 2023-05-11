import 'package:bmovie/const/appconfig.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ImageDisplay extends StatelessWidget {
  final String imageUrl;
  ImageDisplay({required this.imageUrl});

  Widget build(BuildContext context) {
    return AppConfig.local
        ? Image.asset(imageUrl, fit: BoxFit.cover)
        : CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: imageUrl,
            placeholder: (context, url) => Center(
                  child: SpinKitRipple(
                    color: Colors.white,
                    size: 80.0,
                  ),
                ),
            errorWidget: (context, url, error) => Icon(Icons.error));
  }
}
