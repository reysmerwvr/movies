import 'package:flutter/cupertino.dart';
import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
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
            children: <Widget>[_cardSwiper(context)],
          ),
        ));
  }

  Widget _cardSwiper(BuildContext context) {
    final moviesProvider = new MoviesProvider();
    moviesProvider.nowPlaying();
    return CardSwiper(movies: [1, 2, 3, 4, 5]);
  }
}
