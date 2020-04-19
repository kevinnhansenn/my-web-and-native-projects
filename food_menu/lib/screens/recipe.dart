import 'package:flutter/material.dart';
import '../data/original.dart';
import '../models/meal.dart';

class Recipe extends StatefulWidget {
  static const routeName = '/recipe';
  final Function loveMeal;
  final List<Meal> favMeal;

  Recipe(this.loveMeal, this.favMeal);

  @override
  _RecipeState createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  Widget subTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final selectedMenu = DUMMY_MEALS.firstWhere((meal) => meal.id == id);
    bool _isFav = !widget.favMeal.every((meal) => meal.id != id);

    void toggle(String index) {
      widget.loveMeal(index);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(selectedMenu.title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(children: <Widget>[
              Image.network(
                selectedMenu.imageUrl,
                fit: BoxFit.fitWidth,
              ),
              Positioned(
                child: ToggleButtons(
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      size: 40,
                    )
                  ],
                  isSelected: [_isFav],
                  onPressed: (index) {
                    toggle(id);
                  },
                ),
                top: 20,
                right: 20,
              )
            ]),
            subTitle(context, 'Ingredients'),
            Container(
              height: 100,
              margin: EdgeInsets.only(bottom: 10),
              child: ListView.builder(
                  itemCount: selectedMenu.ingredients.length,
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        selectedMenu.ingredients[index],
                        textAlign: TextAlign.center,
                      ),
                    );
                  }),
            ),
            subTitle(context, 'Steps'),
            Container(
              height: 120,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.only(left: 40),
              child: ListView.builder(
                  itemCount: selectedMenu.steps.length,
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '${(index + 1)} ${selectedMenu.steps[index]}',
                      ),
                    );
                  }),
            ),
          ],
        ));
  }
}
