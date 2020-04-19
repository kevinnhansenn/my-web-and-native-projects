import 'package:flutter/material.dart';
import './homepage.dart';
import './favorite.dart';
import '../widgets/my_drawer.dart';
import '../models/meal.dart';

class TabScreen extends StatefulWidget {
  static const routeName = '/';
  final List<Meal> favMeal;

  TabScreen(this.favMeal);
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _currentTab = 0;

  void selectTab(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> tabView = [
      {'route': HomePage(), 'title': 'Homepage'},
      {'route': Favorite(widget.favMeal), 'title': 'Favorite'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(tabView[_currentTab]['title']),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Category'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            title: Text('Favorite'),
          )
        ],
        currentIndex: _currentTab,
        onTap: selectTab,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.yellow,
      ),
      body: tabView[_currentTab]['route'],
      drawer: MyDrawer(),
    );
  }
}

//  TOP NAVIGATION BAR ---------
//      DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'Navigation Topic',
//           ),
//           bottom: TabBar(tabs: <Widget>[
//             Tab(
//               icon: Icon(Icons.category),
//               text: 'Categories',
//             ),
//             Tab(
//               icon: Icon(Icons.star),
//               text: 'Favorites',
//             ),
//           ]),
//         ),
//         body: TabBarView(
//           children: <Widget>[HomePage(), Favorite()],
//         ),
//       ),
//     );
