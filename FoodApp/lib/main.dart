import 'package:FoodApp/screens/categories.dart';
import 'package:FoodApp/screens/mealCategory.dart';
import 'package:FoodApp/screens/mealDetails.dart';
import 'package:FoodApp/screens/settingsScreen.dart';
import 'package:FoodApp/screens/tabsScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Food App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.lightGreen,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              )  
            ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TabsScreen(),
      routes: {
        '/categories': (context) => TabsScreen(),
        '/settings': (context) => SettingsScreen(),
        '/category-meals': (context) => CategoryMealsScreen(),
        MealDetailScreen.routeName: (context) => MealDetailScreen(),
      },
      onUnknownRoute: (settings) {
        //our 404 page here
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
