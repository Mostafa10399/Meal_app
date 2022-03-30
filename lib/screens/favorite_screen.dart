import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;
  FavoriteScreen(this.favoriteMeals);
  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text('you have now Favorite meals '),
      );
    } else {
      return ListView.builder(
        itemBuilder: ((context, index) {
          return MealItem(
            affordability: favoriteMeals[index].affordability,
            complexity: favoriteMeals[index].complexity,
            duration: favoriteMeals[index].duration,
            imageUrl: favoriteMeals[index].imageUrl,
            title: favoriteMeals[index].title,
            id: favoriteMeals[index].id,
          );
        }),
        itemCount: favoriteMeals.length,
      );
    }
  }
}
