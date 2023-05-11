import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../const/appconfig.dart';
import '../const/btextstyle.dart';
import '../models/movie.dart';
import '../services/movieservice.dart';

class UserFeedback extends StatefulWidget {
  final int movieId;
  UserFeedback({required this.movieId});
  @override
  State<UserFeedback> createState() => _UserFeedbackState();
}

class _UserFeedbackState extends State<UserFeedback> {
  List<String> listOfUserFeedbacks = [];
  MovieService _movieService = MovieService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserReviews(widget.movieId);
  }

  void loadUserReviews(int movieId) async {
    listOfUserFeedbacks = !AppConfig.local
        ? await _movieService.getReviews(movieId, "results")
        : _movieService.getLocalUserReviews();
  }

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "User Reviews",
              style: btextheader1,
            ),
          ),
          listOfUserFeedbacks.isEmpty
              ? CircularProgressIndicator()
              : Column(
                  children: listOfUserFeedbacks
                      .map((review) => Text(review))
                      .toList()),
        ]),
      ),
    ));
  }
}

//comments of other users
class UserFeedbackSection extends StatelessWidget {
  final String name;
  final String profilePic;
  final String comment;
  final double profilePicRadius;

  UserFeedbackSection(
      {super.key,
      required this.name,
      required this.profilePic,
      required this.comment,
      required this.profilePicRadius});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
                height: profilePicRadius * 2,
                width: profilePicRadius * 2,
                child: Icon(
                  Icons.person,
                  size: profilePicRadius * 1.5,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(profilePicRadius),
                    color: Theme.of(context).backgroundColor.withOpacity(.9))),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: btextheader2,
                ),
                SizedBox(
                  height: profilePicRadius / 2,
                ),
                SingleChildScrollView(
                  clipBehavior: Clip.antiAlias,
                  child: Text(
                    comment,
                    style: btextheader3,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
