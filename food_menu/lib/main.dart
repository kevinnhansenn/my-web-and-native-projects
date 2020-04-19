import 'package:flutter/material.dart';
import 'package:navigation/screens/tab_screen.dart';
import './screens/detail_menu.dart';
import './screens/recipe.dart';
// import './screens/homepage.dart';
import './screens/tab_screen.dart';
import './screens/settings.dart';
import './data/original.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> validMeal = DUMMY_MEALS;
  List<Meal> favMeal = [];

  Map<String, bool> filters = {
    'isGlutenFree': false,
    'isLactoseFree': false,
    'isVegan': false,
    'isVegetarian': false,
  };

  void loveMeal(String id) {
    print('inside loveMeal');
    setState(() {
      bool notFound = favMeal.every((meal) => meal.id != id);
      if (!notFound) {
        favMeal.removeWhere((meal) => meal.id == id);
      } else {
        favMeal.add(DUMMY_MEALS.where((meal) => meal.id == id).toList()[0]);
      }
      print(favMeal);
    });
  }

  void filterMeal() {
    setState(() {
      validMeal = DUMMY_MEALS.where((meal) {
        if (filters['isGlutenFree'] && !meal.isGlutenFree) {
          return false;
        }
        if (filters['isLactoseFree'] && !meal.isLactoseFree) {
          return false;
        }
        if (filters['isVegan'] && !meal.isVegan) {
          return false;
        }
        if (filters['isVegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void changeFilter(String key, bool newVal) {
    setState(() {
      filters[key] = newVal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.cyanAccent,
        fontFamily: 'RobotoCondensed',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              body1: TextStyle(
                fontFamily: 'Raleway',
              ),
              body2: TextStyle(
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      // home: HomePage(),
      routes: {
        TabScreen.routeName: (ctx) => TabScreen(favMeal),
        DetailMenu.routeName: (ctx) => DetailMenu(validMeal),
        Recipe.routeName: (ctx) => Recipe(loveMeal, favMeal),
        Settings.routeName: (ctx) =>
            Settings(filters, changeFilter, filterMeal),
      },
      // onGenerateRoute: (settings) {
      //   // print(settings.arguments);
      // },
      // onUnknownRoute: (settings) {
      //   // 404 Page
      // },
    );
  }
}
