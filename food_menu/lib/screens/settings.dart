import 'package:flutter/material.dart';
import '../widgets/my_drawer.dart';

class Settings extends StatelessWidget {
  static const routeName = '/settings';

  final Map<String, bool> filters;
  final Function changeFilter;
  final Function filterMeal;

  Settings(this.filters, this.changeFilter, this.filterMeal);

  Widget switchTile(String title, String subtitle, String key) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      onChanged: (newVal) {
        changeFilter(key, newVal);
      },
      value: filters[key],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: filterMeal,
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text(
              'Filters',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
            switchTile('Glucose Free', 'Only show the glucose free food',
                'isGlutenFree'),
            switchTile('Lactose Free', 'Only show the lactore free food',
                'isLactoseFree'),
            switchTile('Only Vegan', 'Only show the the vegan food', 'isVegan'),
            switchTile('Only Vegetarian', 'Only show the the vegetarian food',
                'isVegetarian'),
          ],
        ),
      ),
    );
  }
}
