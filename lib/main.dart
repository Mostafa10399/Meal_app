import 'package:flutter/material.dart';
import './dummy_data.dart';
import './models/meal.dart';

import './screens/tabs_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/category_meal_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/filters_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };
  List<Meal> favoriteMeal = [];
  List<Meal> avilableMeals = DUMMY_MEALS;
  void toggleFavorite(String mealid) {
    final existingIndex = favoriteMeal.indexWhere((meal) {
      return mealid == meal.id;
    });
    if (existingIndex >= 0) {
      setState(() {
        favoriteMeal.removeAt(existingIndex);
      });
    } else {
      setState(() {
        favoriteMeal.add(DUMMY_MEALS.firstWhere((meal) {
          return meal.id == mealid;
        }));
      });
    }
  }

  bool _isMealFavorite(String mealID) {
    return favoriteMeal.any((meal) {
      return meal.id == mealID;
    });
  }

  void _setFilters(Map<String, bool> filtersData) {
    setState(() {
      filters = filtersData;

      avilableMeals = DUMMY_MEALS.where((meal) {
        if (filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        // fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                  fontFamily: 'Raleway',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              bodyText2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                  fontFamily: 'Raleway',
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
        appBarTheme: AppBarTheme(
            titleTextStyle:
                TextStyle(fontSize: 24, fontFamily: 'RobotoCondensed')),
      ),
      // home: CategoriesScreen(),

      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(favoriteMeal),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(avilableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(filters, _setFilters)
      },
    );
  }
}
