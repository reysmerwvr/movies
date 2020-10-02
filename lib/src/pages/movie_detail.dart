import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/src/models/cast_model.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movies_provider.dart';

class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return CupertinoPageScaffold(
      child: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            _createAppBar(movie),
            SliverList(
                delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 5.0,
                ),
                _createCard(movie),
                _createPosterTitle(context, movie),
                _description(movie),
                _createCast(movie),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget _createAppBar(Movie movie) {
    return CupertinoSliverNavigationBar(
      backgroundColor: CupertinoColors.systemGrey6,
      automaticallyImplyLeading: true,
      largeTitle: Center(
        child: Text(
          movie.title,
          style: TextStyle(color: CupertinoColors.black, fontSize: 36.0),
        ),
      ),
    );
  }

  Widget _createCard(Movie movie) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(movie.getBackdropPath()),
              placeholder: AssetImage('assets/images/loading.gif'),
              fadeInDuration: Duration(milliseconds: 150),
              height: 200.0,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _createPosterTitle(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(movie.getPosterImage()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  movie.title,
                  style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  movie.originalTitle,
                  style: CupertinoTheme.of(context).textTheme.textStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      CupertinoIcons.heart,
                      color: CupertinoColors.black,
                    ),
                    Text(
                      movie.voteAverage.toString(),
                      style: CupertinoTheme.of(context).textTheme.textStyle,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _description(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _createCast(Movie movie) {
    final moviesProvider = MoviesProvider();
    return FutureBuilder(
        future: moviesProvider.getCast(movie.id.toString()),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return _createCastPageView(snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _createCastPageView(List<Cast> actors) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        itemCount: actors.length,
        itemBuilder: (context, i) => _actorCard(actors[i]),
      ),
    );
  }

  Widget _actorCard(Cast actor) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/images/no-image.jpg'),
              image: NetworkImage(actor.getPicture()),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
