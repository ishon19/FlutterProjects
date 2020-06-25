import '../widgets/categoryItem.dart';
import 'package:FoodApp/dummyData.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: DUMMY_CATEGORIES.map((categoryData) {
          return CategoryItem(
            id: categoryData.id,
            title: categoryData.title,
            color: categoryData.color,
          );
        }).toList(),
      );
  }
}
