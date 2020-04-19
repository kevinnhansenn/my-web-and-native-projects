import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../models/meal.dart';

class MenuResult extends StatelessWidget {
  final String id;
  final String title;
  final Affordability affordability;
  final Complexity complexity;
  final String imageUrl;
  final int duration;

  String get getAff {
    switch (affordability) {
      case Affordability.Affordable:
        return 'Affordable';
        break;
      case Affordability.Pricey:
        return 'Pricey';
        break;
      case Affordability.Luxurious:
        return 'Luxurious';
        break;
      default:
        return 'Unknown';
        break;
    }
  }

  String get getCom {
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';
        break;
      case Complexity.Hard:
        return 'Hard';
        break;
      case Complexity.Challenging:
        return 'Challenging';
        break;
      default:
        return 'Unknown';
        break;
    }
  }

  void selectMenu(BuildContext ctx) {
    Navigator.of(ctx).pushNamed('/recipe', arguments: id);
    // Navigator.of(ctx).pushNamed('/recipe', arguments: id).then((_) {
    //   // do something
    // });
  }

  MenuResult({
    @required this.id,
    @required this.title,
    @required this.affordability,
    @required this.complexity,
    @required this.imageUrl,
    @required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        selectMenu(context);
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
        elevation: 10,
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Stack(children: <Widget>[
                Image.network(imageUrl),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    width: 250,
                    color: Colors.white54,
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.display1,
                      overflow: TextOverflow.fade,
                      softWrap: true,
                    ),
                  ),
                )
              ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.attach_money),
                      SizedBox(
                        width: 3,
                      ),
                      Text(getAff)
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.schedule),
                      SizedBox(
                        width: 3,
                      ),
                      Text('$duration mins')
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.work),
                      SizedBox(
                        width: 3,
                      ),
                      Text(getCom)
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
