import 'package:FoodApp/dummyData.dart';
import 'package:FoodApp/screens/categories.dart';
import 'package:FoodApp/screens/mealCategory.dart';
import 'package:FoodApp/screens/mealDetails.dart';
import 'package:FoodApp/screens/settingsScreen.dart';
import 'package:FoodApp/screens/tabsScreen.dart';
import 'package:flutter/material.dart';

import 'models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filter = {
    'gluten': false,
    'lactose': false,
    'veg': false,
    'vegan': false,
  };

  List<Meal> _allMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filter = filterData;
      print('received data $_filter');
      _allMeals = DUMMY_MEALS.where((meals) {
        if (_filter['gluten'] && !meals.isGlutenFree) return false;
        if (_filter['lactose'] && !meals.isLactoseFree) return false;
        if (_filter['vegan'] && !meals.isVegan) return false;
        if (_filter['veg'] && !meals.isVegetarian) return false;
        return true;
      }).toList();
      print('All meals now : $_allMeals');
    });
  }

  void toggleFavorites(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((element) => element.id == mealId);
    
    if(existingIndex>=0){
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String mealId) {
    return _favoriteMeals.any((element) => element.id == mealId);
  }

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
            )),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TabsScreen(_favoriteMeals),
      routes: {
        '/categories': (context) => TabsScreen(_favoriteMeals),
        '/settings': (context) => SettingsScreen(_filter, _setFilters),
        '/category-meals': (context) => CategoryMealsScreen(_allMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(toggleFavorites, _isMealFavorite),
      },
      onUnknownRoute: (settings) {
        //our 404 page here
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
