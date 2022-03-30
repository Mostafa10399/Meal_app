import 'package:flutter/material.dart';
import '../models/meal.dart';

import './favorite_screen.dart';
import './categories_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  // const TabScreen({ Key? key }) : super(key: key);
  final List<Meal> favoriteMeals;
  TabsScreen(this.favoriteMeals);
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages; 
  int selectedPageIndex = 0;
  @override
  void initState() {
    _pages=[
          {'page': CategoriesScreen(), 'title': 'Categories'},
          {'page': FavoriteScreen(widget.favoriteMeals), 'title': 'Favorites'}
        ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[selectedPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages[selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: selectedPageIndex,
        // type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.category),
              label: 'Categories'),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.star),
              label: 'Favorites'),
        ],
      ),
    );
  }
}
