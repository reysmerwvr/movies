import 'package:flutter/cupertino.dart';
import 'package:movies/src/models/movie_model.dart';

class MovieLandscape extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPage;

  MovieLandscape({@required this.movies, @required this.nextPage});

  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        // children: _cards(context),
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int i) => _card(context, movies[i]),
      ),
    );
  }

  Widget _card(BuildContext context, Movie movie) {
    final card = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/images/no-image.jpg'),
              image: NetworkImage(movie.getPosterImage()),
              fit: BoxFit.cover,
              height: 160.0,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Center(
            child: Text(movie.title,
                overflow: TextOverflow.ellipsis,
                style: CupertinoTheme.of(context).textTheme.textStyle),
          )
        ],
      ),
    );

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'detail', arguments: movie);
      },
      child: card,
    );
  }

  List<Widget> _cards(BuildContext context) {
    return movies.map((movie) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/images/no-image.jpg'),
                image: NetworkImage(movie.getPosterImage()),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Center(
              child: Text(movie.title,
                  overflow: TextOverflow.ellipsis,
                  style: CupertinoTheme.of(context).textTheme.textStyle),
            )
          ],
        ),
      );
    }).toList();
  }
}
