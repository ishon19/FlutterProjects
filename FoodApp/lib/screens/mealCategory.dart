import 'package:FoodApp/dummyData.dart';
import 'package:FoodApp/widgets/mealItem.dart';
import 'package:flutter/material.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatelessWidget {
  // final String categoryID, categoryTitle;

  // CategoryMealsScreen({@required this.categoryID, @required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'], categoryID = routeArgs['id'];
    final fileteredMeals = DUMMY_MEALS.where((element) {
      return element.categories.contains(categoryID);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: Container(
        child: Center(
          child: ListView.builder(
            itemBuilder: (ctx, idx) {
              return MealItem(
                  title: fileteredMeals[idx].title,
                  duration: fileteredMeals[idx].duration,
                  imageUrl: fileteredMeals[idx].imageUrl,
                  affordability: fileteredMeals[idx].affordability,
                  complexity: fileteredMeals[idx].complexity);
            },
            itemCount: fileteredMeals.length,
          ),
        ),
      ),
    );
  }
}
