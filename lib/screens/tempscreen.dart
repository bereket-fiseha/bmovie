import 'package:bmovie/models/moviedetail.dart';
import 'package:bmovie/screens/discovermovies.dart';
import 'package:bmovie/screens/moviesearch.dart';
import 'package:bmovie/screens/setting.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';
import 'moviedetail.dart';

class TempScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return CircularMenu(
        toggleButtonColor: Theme.of(context).primaryColor,
        alignment: Alignment.bottomRight,
        items: [
          CircularMenuItem(
            icon: Icons.home,
            color: Theme.of(context).primaryColor,
            iconColor: Colors.white,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => DiscoverMovies()));
            },
            margin: 15.0,
            padding: 15.0,
          ),
          CircularMenuItem(
            badgeRadius: 50,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => MovieSearch()));
            },
            icon: Icons.search,
            color: Theme.of(context).primaryColor,
            iconSize: 30.0,
          ),
          CircularMenuItem(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => AppSetting()));
            },
            iconSize: 30.0,
            color: Theme.of(context).primaryColor,
            icon: Icons.settings,
          ),
        ],
        backgroundWidget: DiscoverMovies());
  }
}
