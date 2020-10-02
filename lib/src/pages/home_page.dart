import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';
import 'package:movies/src/widgets/movie_landscape.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    moviesProvider.getMostPopularMovies();

    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.systemGrey6,
          middle: Text("Cinema Movies"),
          trailing: Container(
            child: CupertinoButton(
                child: Icon(
                  CupertinoIcons.search,
                  color: CupertinoColors.black,
                ),
                onPressed: () {}),
          ),
        ),
        child: Container(
          child: Column(
            children: <Widget>[_cardSwiper(context), _footer(context)],
          ),
        ));
  }

  Widget _cardSwiper(BuildContext context) {
    return FutureBuilder(
      future: moviesProvider.nowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(movies: snapshot.data);
        } else {
          return Container(
              height: 400.0,
              child: Center(child: CupertinoActivityIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              "Most Popular",
              style: CupertinoTheme.of(context).textTheme.textStyle,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
            stream: moviesProvider.mostPopularMoviesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieLandscape(
                  movies: snapshot.data,
                  nextPage: moviesProvider.getMostPopularMovies,
                );
              } else {
                return Center(child: CupertinoActivityIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
