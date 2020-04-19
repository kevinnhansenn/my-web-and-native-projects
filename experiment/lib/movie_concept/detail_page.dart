import 'package:flutter/material.dart';
import './main_page.dart';

class DetailPage extends StatelessWidget {
  final Movie movie;

  DetailPage(this.movie);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              SizedBox(
                height: height * 0.65,
                width: double.infinity,
                child: Hero(
                  tag: movie.title,
                  child: Image.network(
                    movie.url,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 10,
                child: BackButton(
                  color: Colors.white,
                ),
              ),
              Positioned(
                top: 55,
                right: 20,
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
          Container(
            height: height * 0.35,
            width: double.infinity,
            color: Colors.grey[200],
            child: Column(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'MOVIE TITLE',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
                Text(
                  'Synopsis',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    """Forever alone in a crowd, failed comedian Arthur Fleck seeks connection as he walks the streets of Gotham City. Arthur wears two masks -- the one he paints for his day job as a clown, and the guise he projects in a futile attempt to feel like he\'s part of the world around him. Isolated, bullied and disregarded by society, Fleck begins a slow descent into madness as he transforms into the criminal mastermind known as the Joker.""",
                    style: TextStyle(color: Colors.grey[600]),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
