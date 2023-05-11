import 'package:bmovie/const/apiroute.dart';
import 'package:bmovie/const/appcolors.dart';
import 'package:bmovie/const/btextstyle.dart';
import 'package:bmovie/models/enum.dart';
import 'package:bmovie/models/moviedetail.dart';
import 'package:bmovie/screens/imageslider.dart';
import 'package:bmovie/screens/moviesearch.dart';
import 'package:bmovie/services/movieservice.dart';
import 'package:bmovie/widgets/imagedisplay.dart';
import 'package:bmovie/widgets/moviesmallposter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../const/appconfig.dart';
import '../models/movie.dart';
import 'moviedetail.dart';

class DiscoverMovies extends StatefulWidget {
  const DiscoverMovies({super.key});

  @override
  State<DiscoverMovies> createState() => _DiscoverMoviesState();
}

class _DiscoverMoviesState extends State<DiscoverMovies> {
  final MovieService _movieService = MovieService();
  List<Movie> listOfNowPlayingMovies = [];
  List<Movie> listOfTopRatedMovies = [];
  List<Movie> listOfPopularMovies = [];

  @override
  void initState() {
    // TODO: implement initState
    loadPopularMovies();
    loadTopRatedMovies();
    loadNowPlayingMovies();
  }

  void loadNowPlayingMovies() async {
    if (AppConfig.local) {
      listOfNowPlayingMovies = _movieService.getLocalMovieList();
    } else {
      var movies = await _movieService.getAllMovies(APIROUTE.Now_Playing);
      setState(() {
        listOfNowPlayingMovies = movies;
      });
    }
  }

  void loadTopRatedMovies() async {
    if (AppConfig.local) {
      listOfTopRatedMovies = _movieService.getLocalMovieList();
    } else {
      var movies = await _movieService.getAllMovies(APIROUTE.Top_Rated);
      setState(() {
        listOfTopRatedMovies = movies;
      });
    }
  }

  void loadPopularMovies() async {
    if (AppConfig.local) {
      listOfPopularMovies = _movieService.getLocalMovieList();
    } else {
      var movies = await _movieService.getAllMovies(APIROUTE.Popular);
      setState(() {
        listOfPopularMovies = movies;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const SearchAppBar(),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: Drawer(
          child: ListView(
        children: const [
          DrawerHeader(
            decoration: BoxDecoration(color: bprimarycolor),
            child: Text("header"),
          ),
          ListTile(
            title: Text("item 1"),
          ),
          ListTile(
            title: Text("item 2"),
          )
        ],
      )),
      body: ListView(
        children: [
          DiscoverCarousal(
            height: heightOfScreen / 3,
            width: widthOfScreen / 1.4,
            discoverMovies: listOfPopularMovies,
          ),
          TopRatedListView(
            height: heightOfScreen / 3,
            width: widthOfScreen / 3,
            topRatedMovies: listOfTopRatedMovies,
          ),
          NowPlayingListView(
            height: heightOfScreen / 2.9,
            width: widthOfScreen / 3,
            nowPlayingMovies: listOfNowPlayingMovies,
          )
        ],
      ),
    );
  }
}

class DiscoverCarousal extends StatelessWidget {
  const DiscoverCarousal({
    Key? key,
    required this.height,
    required this.width,
    required this.discoverMovies,
  }) : super(key: key);

  final double height;
  final double width;
  final List<Movie> discoverMovies;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Discover", style: btextheader1),
              Row(
                children: [
                  Text("", style: btextheader3),
                  SizedBox(
                    width: 5,
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.eye),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ImageSlider(
                                  sliderType: SliderType.CardSlider,
                                  listOfMovies: discoverMovies,
                                  title: "Disover Movies")));
                    },
                  )
                ],
              )
            ],
          ),
        ),
        discoverMovies == []
            ? Container()
            : MovieImageAndTitleCarousel(
                width: width, height: height, discoverMovies: discoverMovies)
      ],
    );
  }
}

class MovieImageAndTitleCarousel extends StatelessWidget {
  const MovieImageAndTitleCarousel({
    Key? key,
    required this.width,
    required this.height,
    required this.discoverMovies,
  }) : super(key: key);

  final double width;
  final double height;
  final List<Movie> discoverMovies;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: discoverMovies
          .map((movie) => SizedBox(
                height: height,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height / 1.2,
                        child: InkWell(
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MovieDetails(movie: movie)))
                          },
                          child: discoverMoviePoster(
                              movie.getImage(), width, context),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: Text(
                          movie.getTitle(),
                          style: btextheader3,
                        ),
                      )
                    ]),
              ))
          .toList(),
      options: CarouselOptions(
          height: height, autoPlay: true, viewportFraction: 0.78),
    );
  }
}

Widget discoverMoviePoster(String image, double width, BuildContext context) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(25),
    child: Container(
        width: width,
        color: Theme.of(context).backgroundColor.withOpacity(.6),
        child: ImageDisplay(
          imageUrl: image,
        )),
  );
}

class TopRatedListView extends StatelessWidget {
  const TopRatedListView(
      {Key? key,
      required this.height,
      required this.width,
      required this.topRatedMovies})
      : super(key: key);

  final double height;
  final double width;
  final List<Movie> topRatedMovies;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Top Rated", style: btextheader1),
                Row(
                  children: [
                    const Text("", style: btextheader3),
                    SizedBox(
                      width: 5,
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.eye),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ImageSlider(
                                    sliderType: SliderType.ListWheel,
                                    listOfMovies: topRatedMovies,
                                    title: "Top Rated")));
                      },
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: topRatedMovies == []
                ? Container()
                : ListView(
                    scrollDirection: Axis.horizontal,
                    children: topRatedMovies
                        .map((movie) =>
                            TopRatedImageAndTitleColumn(context, movie))
                        .toList(),
                  ),
          )
        ],
      ),
    );
  }

  Widget TopRatedImageAndTitleColumn(BuildContext context, Movie movie) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => MovieDetails(movie: movie)));
      },
      child: SizedBox(
        height: height - 50,
        child: Column(children: [
          Expanded(
            child: MovieSmallPoster(
              imagePath: movie.getImage(),
              width: width,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "${movie.getTitle().substring(0, movie.getTitle().length < 15 ? movie.getTitle().length : 15)}...",
            style: btextheader3,
          )
        ]),
      ),
    );
  }
}

class NowPlayingListView extends StatelessWidget {
  const NowPlayingListView(
      {Key? key,
      required this.height,
      required this.width,
      required this.nowPlayingMovies})
      : super(key: key);

  final double height;
  final double width;
  final List<Movie> nowPlayingMovies;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Now Playing", style: btextheader1),
                Row(
                  children: [
                    const Text("", style: btextheader3),
                    const SizedBox(
                      width: 5,
                    ),
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.eye),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ImageSlider(
                                    listOfMovies: nowPlayingMovies,
                                    sliderType: SliderType.ListWheel,
                                    title: "Now Playing")));
                      },
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: nowPlayingMovies == []
                ? Container()
                : ListView(
                    scrollDirection: Axis.horizontal,
                    children: nowPlayingMovies
                        .map((movie) =>
                            NowPlayingImageAndTitleColumn(context, movie))
                        .toList()),
          )
        ],
      ),
    );
  }

  Widget NowPlayingImageAndTitleColumn(BuildContext context, Movie movie) {
    return InkWell(
      onTap: () => {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MovieDetails(movie: movie)))
      },
      child: SizedBox(
        height: height - 50,
        child: Column(children: [
          Expanded(
            child: MovieSmallPoster(
              imagePath: movie.getImage(),
              width: width,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "${movie.getTitle().substring(0, movie.getTitle().length < 15 ? movie.getTitle().length : 15)}...",
            style: btextheader3,
          )
        ]),
      ),
    );
  }
}

class SearchAppBar extends StatefulWidget {
  const SearchAppBar({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool _isSearchFieldOpened = false;
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!_isSearchFieldOpened)
          Container(
              alignment: Alignment.center,
              child: const Text("Bmovies",
                  style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(
            child: Align(
                alignment: Alignment.centerRight,
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 400),
                  child: _isSearchFieldOpened
                      ? Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 198, 193, 193),
                              borderRadius: BorderRadius.circular(5)),
                          width: double.infinity,
                          child: TextField(
                            controller: _textEditingController,
                            decoration: InputDecoration(
                                hintText: 'Search for movie',
                                prefixIcon: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) => MovieSearch(
                                                term: _textEditingController
                                                    .text))));
                                  },
                                ),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isSearchFieldOpened = false;
                                      });
                                    },
                                    icon: const Icon(Icons.close))),
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              _isSearchFieldOpened = true;
                            });
                          },
                          icon: const Icon(Icons.search)),
                ))),
      ],
    );
  }
}
