import 'package:FoodApp/dummyData.dart';
import 'package:FoodApp/widgets/mealItem.dart';
import 'package:flutter/material.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  // final String categoryID, categoryTitle;

  // CategoryMealsScreen({@required this.categoryID, @required this.categoryTitle});
  List<Meal> allMeals;

  CategoryMealsScreen(this.allMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> fileteredMeals;
  bool dataLoaded = false;

  void _removeItem(String mealId) {
    setState(() {
      fileteredMeals.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if(!dataLoaded){
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryID = routeArgs['id'];
      fileteredMeals = widget.allMeals.where((element) {
        return element.categories.contains(categoryID);
      }).toList();
      dataLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: Container(
        child: Center(
          child: ListView.builder(
            itemBuilder: (ctx, idx) {
              return MealItem(
                  id: fileteredMeals[idx].id,
                  title: fileteredMeals[idx].title,
                  duration: fileteredMeals[idx].duration,
                  imageUrl: fileteredMeals[idx].imageUrl,
                  affordability: fileteredMeals[idx].affordability,
                  complexity: fileteredMeals[idx].complexity,);
            },
            itemCount: fileteredMeals.length,
          ),
        ),
      ),
    );
  }
}
