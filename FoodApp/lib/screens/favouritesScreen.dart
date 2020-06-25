import 'package:FoodApp/models/meal.dart';
import 'package:FoodApp/widgets/mealItem.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  FavoritesScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text(
          'No Favorites Added Yet!',
          style: Theme.of(context).textTheme.headline6,
        ),
      );
    } else {
      return  ListView.builder(
            itemBuilder: (ctx, idx) {
              return MealItem(
                  id: favoriteMeals[idx].id,
                  title: favoriteMeals[idx].title,
                  duration: favoriteMeals[idx].duration,
                  imageUrl: favoriteMeals[idx].imageUrl,
                  affordability: favoriteMeals[idx].affordability,
                  complexity: favoriteMeals[idx].complexity,);
            },
            itemCount: favoriteMeals.length,
          );
    }
  }
}
