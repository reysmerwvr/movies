import 'package:flutter/cupertino.dart';
import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';
import 'package:movies/src/widgets/movie_landscape.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.activeGreen,
          middle: Text("Cinema Movies"),
          trailing: Container(
            child: CupertinoButton(
                child: Icon(
                  CupertinoIcons.search,
                  color: CupertinoColors.white,
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
          FutureBuilder(
            future: moviesProvider.getMostPopular(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieLandscape(movies: snapshot.data);
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
