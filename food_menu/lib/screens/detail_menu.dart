import 'package:flutter/material.dart';
import '../widgets/menu_result.dart';

class DetailMenu extends StatelessWidget {
  static const routeName = '/detail-menu';

  final List validMeal;
  DetailMenu(this.validMeal);

  @override
  Widget build(BuildContext context) {
    final extractArgument =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final id = extractArgument['id'];
    final title = extractArgument['title'];
    final matchedId = validMeal.where((meal) {
      return meal.categories.contains(id);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MenuResult(
            id: matchedId[index].id,
            title: matchedId[index].title,
            affordability: matchedId[index].affordability,
            complexity: matchedId[index].complexity,
            duration: matchedId[index].duration,
            imageUrl: matchedId[index].imageUrl,
          );
        },
        itemCount: matchedId.length,
      ),
    );
  }
}
