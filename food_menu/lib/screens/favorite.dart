import 'package:flutter/material.dart';
import '../widgets/menu_result.dart';
import '../models/meal.dart';

class Favorite extends StatelessWidget {
  final List<Meal> favMeal;
  Favorite(this.favMeal);

  @override
  Widget build(BuildContext context) {
    return favMeal.isEmpty
        ? Center(
            child: Text(
              'There is currently no favorite!',
            ),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return MenuResult(
                id: favMeal[index].id,
                title: favMeal[index].title,
                affordability: favMeal[index].affordability,
                complexity: favMeal[index].complexity,
                duration: favMeal[index].duration,
                imageUrl: favMeal[index].imageUrl,
              );
            },
            itemCount: favMeal.length,
          );
  }
}
