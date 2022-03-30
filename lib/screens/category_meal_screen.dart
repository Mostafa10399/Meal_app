import 'package:flutter/material.dart';
import '../models/meal.dart';

import '../widgets/meal_item.dart';

import '../dummy_data.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  List<Meal> avilableMeals;
  CategoryMealsScreen(this.avilableMeals);
  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  var loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final String categoryID = routeArgs['id'];
      displayedMeals = widget.avilableMeals.where((meal) {
        return meal.categories.contains(categoryID);
      }).toList();
      loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void removeMeal(String mealID) {
    setState(() {
      displayedMeals.removeWhere((element) => element.id == mealID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
          itemBuilder: ((context, index) {
            return MealItem(
              affordability: displayedMeals[index].affordability,
              complexity: displayedMeals[index].complexity,
              duration: displayedMeals[index].duration,
              imageUrl: displayedMeals[index].imageUrl,
              title: displayedMeals[index].title,
              id: displayedMeals[index].id,
            );
          }),
          itemCount: displayedMeals.length,
        ));
  }
}
